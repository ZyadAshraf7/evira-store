import 'package:bloc/bloc.dart';
import 'package:evira_store/core/app_router/my_app_router.dart';
import 'package:evira_store/data/shared_preference/shared_preference.dart';
import 'package:evira_store/evira_store.dart';
import 'package:evira_store/presentation/cubits/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
    Bloc.observer = MyGlobalObserver();
    runApp(EviraStore(appRouter: AppRouter(),));
}

