import 'package:evira_store/core/app_router/route_names.dart';
import 'package:evira_store/core/theme/app_theme.dart';
import 'package:evira_store/presentation/cubits/onboarding_screens/onboarding_cubit.dart';
import 'package:evira_store/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, i) {
          cubit.index = i;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Flexible(flex: 5,child: Image.asset(cubit.images[cubit.index],fit: BoxFit.cover,)),
                const SizedBox(height: 20),
                Flexible(
                  flex: 2,
                  child: Text(
                    cubit.titles[cubit.index],
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: AppTheme.grey900),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(cubit.titles.length, (index) {
                    return Container(
                      width: cubit.index == index ? 20.0 : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.primary500),
                        color: cubit.index == index
                            ? AppTheme.primary500
                            : Colors.transparent,
                      ),
                    );
                  }),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          onTap: () {
                            cubit.index==cubit.titles.length - 1?Navigator.pushNamed(context,RouteNames.loginScreen):cubit.controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          title: cubit.index == cubit.titles.length - 1
                              ? "Get Started":"Next"),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
        controller: cubit.controller,
        onPageChanged: (page) {
          cubit.screenChanged(page);
        },
        itemCount: cubit.titles.length,
      ),
    );
  }
}
