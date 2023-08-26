import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  List<String> titles = [
    "We provide high quality products just for you",
    "Your satisfaction is our number one priority",
    "Let's fulfill your daily needs with Evira right now!"
  ];
  List<String> images = [
    "assets/images/onboarding1_1.png",
    "assets/images/onboarding1_2.png",
    "assets/images/onboarding1_3.png"
  ];

  //current page index
  int index = 0;
  final PageController controller = PageController();

  void screenChanged(int page) {
    index = page;
    emit(OnboardingScreenChanged());
  }

  navigateToSecondScreen() {
    if (index < titles.length - 1) {
      controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Navigate to the home screen or sign up page
    }
  }
}
