import 'package:first_task_1/core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'package:first_task_1/core/controllers/onboarding_cubit/onboarding_states.dart';
import 'package:first_task_1/core/managers/lists.dart';
import 'package:first_task_1/screens/widgets/botton.dart';
import 'package:first_task_1/screens/widgets/build_onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnboardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var boardingController = PageController();
        var cubit = OnBoardingCubit.get(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pixel',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 450,
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == onboarding.length - 1) {
                      cubit.pageLast(index);
                    } else {
                      cubit.pageNotLast(index);
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(onboarding[index]),
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: onboarding.length,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              cubit.isPageLast
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultButton(
                        backgroundColor: Colors.black,
                        function: () {
                          cubit.submit(context);
                        },
                        buttonWidget: const Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultButton(
                        function: () {
                          boardingController.nextPage(
                              duration: const Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                        buttonWidget: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
