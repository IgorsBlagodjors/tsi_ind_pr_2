// Node 18+. Dry run: node tool/import_doctors.mjs
// Import: FIRESTORE_ACCESS_TOKEN must contain a Google OAuth access token
// with Firestore IAM access, then run with --write. Never use a mobile API key.
import { readFileSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { isDeepStrictEqual } from 'node:util';

const project = 'tsiindproject2';
const root = `projects/${project}/databases/(default)/documents`;
const endpoint = `https://firestore.googleapis.com/v1/${root}`;
const records = JSON.parse(readFileSync(new URL('./doctors.seed.json', import.meta.url), 'utf8'));
const ids = new Set();
for (const { id, data } of records) {
  if (!id || id.includes('/') || ids.has(id)) throw new Error(`Invalid ID: ${id}`);
  ids.add(id);
  for (const field of ['name', 'type', 'specialization', 'image']) {
    if (typeof data[field] !== 'string' || !data[field]) throw new Error(`${id}: missing ${field}`);
  }
  if ('isFavorite' in data) throw new Error('User favorites cannot be stored on a doctor.');
}

function encode(value) {
  if (value === null) return { nullValue: null };
  if (typeof value === 'string') return { stringValue: value };
  if (typeof value === 'boolean') return { booleanValue: value };
  if (typeof value === 'number') return Number.isInteger(value)
    ? { integerValue: String(value) } : { doubleValue: value };
  if (Array.isArray(value)) return { arrayValue: { values: value.map(encode) } };
  throw new Error('Unsupported field value');
}

function decode(value) {
  if ('nullValue' in value) return null;
  if ('stringValue' in value) return value.stringValue;
  if ('booleanValue' in value) return value.booleanValue;
  if ('integerValue' in value) return Number(value.integerValue);
  if ('doubleValue' in value) return value.doubleValue;
  if ('arrayValue' in value) return (value.arrayValue.values ?? []).map(decode);
  throw new Error('Unexpected field type in existing document');
}

async function main() {
  console.log(`Target: ${project}/(default)/doctors; ${records.length} demo doctors.`);
  if (!process.argv.includes('--write')) {
    console.log('Local validation passed. No network requests or writes made.');
    console.log('Use --write after authenticating with Google Cloud.');
    return;
  }
  let token = process.env.FIRESTORE_ACCESS_TOKEN;
  if (!token) {
    try {
      token = execFileSync('gcloud', ['auth', 'print-access-token'], {
        encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'],
      }).trim();
    } catch {
      throw new Error('No Google authorization. Run in authenticated Google Cloud Shell, or supply FIRESTORE_ACCESS_TOKEN locally.');
    }
  }
  if (!token) throw new Error('Empty access token');
  async function request(url, body) {
    const response = await fetch(url, {
      method: body ? 'POST' : 'GET',
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
      ...(body ? { body: JSON.stringify(body) } : {}),
      signal: AbortSignal.timeout(30000),
    });
    if (response.status === 404 && !body) return null;
    if (!response.ok) throw new Error(`Firestore HTTP ${response.status}: ${(await response.json()).error?.message ?? 'request failed'}`);
    return response.json();
  }
  function matches(document, data) {
    return isDeepStrictEqual(
      Object.fromEntries(Object.entries(document.fields ?? {}).map(([key, value]) => [key, decode(value)])),
      data,
    );
  }
  const writes = [];
  for (const { id, data } of records) {
    const existing = await request(`${endpoint}/doctors/${encodeURIComponent(id)}`);
    if (existing) {
      if (!matches(existing, data)) throw new Error(`Existing doctor ${id} differs; stopped without writing any doctors.`);
      continue;
    }
    writes.push({
      update: {
        name: `${root}/doctors/${id}`,
        fields: Object.fromEntries(Object.entries(data).map(([key, value]) => [key, encode(value)])),
      },
      currentDocument: { exists: false },
    });
  }
  if (writes.length) await request(`${endpoint}:commit`, { writes });
  for (const { id, data } of records) {
    const saved = await request(`${endpoint}/doctors/${encodeURIComponent(id)}`);
    if (!saved || !matches(saved, data)) throw new Error(`Verification failed for ${id}`);
  }
  console.log(`Verified ${records.length} doctors in Firestore; created ${writes.length}, already present ${records.length - writes.length}.`);
}

main().catch((error) => {
  console.error(error.message);
  process.exitCode = 1;
});
