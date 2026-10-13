import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/domain/app_access.dart';

void main() {
  test('restored credentials stay locked until explicitly authenticated', () {
    final access = AppAccess();
    expect(access.allows('saved-user'), isFalse);
    access.unlock('saved-user');
    expect(access.allows('saved-user'), isTrue);
    expect(access.allows('another-user'), isFalse);
    expect(access.allows(null), isFalse);
    access.lock();
    expect(access.allows('saved-user'), isFalse);
    access.dispose();
  });
}
