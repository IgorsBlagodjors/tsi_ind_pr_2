import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsi_ind_pr_2/data/doctors/doctors_repository.dart';
import 'package:tsi_ind_pr_2/data/doctors/firebase_doctors_repository.dart';
import 'package:tsi_ind_pr_2/domain/auth_repository.dart';
import 'package:tsi_ind_pr_2/domain/app_access.dart';
import 'package:tsi_ind_pr_2/data/users/firebase_auth_repository.dart';
import 'package:tsi_ind_pr_2/data/users/profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsi_ind_pr_2/app/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Android configuration is loaded from google-services.json.
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (!AppAccess.instance.allows(user?.uid)) AppAccess.instance.lock();
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final doctorRepository = RepositoryProvider<DoctorsRepository>(
    create: (_) => FirebaseDoctorsRepository(),
  );
  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;
  final authRepository = RepositoryProvider<AuthRepository>(
    create: (_) => FirebaseAuthRepository(FirebaseAuth.instance),
  );

  final profileRepository = RepositoryProvider<ProfileRepository>(
    create: (_) => ProfileRepository(),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [authRepository, profileRepository, doctorRepository],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'League Spartan',
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF13CAD6),
                surface: Colors.white,
              ),
            ),
            routerConfig: appRouter,
          );
        },
      ),
    ),
  );
}
