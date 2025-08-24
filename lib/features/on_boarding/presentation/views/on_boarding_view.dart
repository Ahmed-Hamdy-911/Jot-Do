import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/assets/app_assets.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../manager/cubits/onBoarding/on_boarding_cubit.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/on_boarding_model.dart';
import '../widgets/custom_next_button.dart';
import '../widgets/custom_skip_button.dart';
import '../widgets/custom_smooth_page_indicator.dart';
import '../widgets/page_view_builder.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    final List<OnBoardingModel> _pages = [
      OnBoardingModel(
        title: S.of(context).onBoardingTitle1,
        description: S.of(context).onBoardingDesc1,
        image: AppAssets.onBoarding1,
      ),
      OnBoardingModel(
        title: S.of(context).onBoardingTitle2,
        description: S.of(context).onBoardingDesc2,
        image: AppAssets.onBoarding2,
      ),
      OnBoardingModel(
        title: S.of(context).onBoardingTitle3,
        description: S.of(context).onBoardingDesc3,
        image: AppAssets.onBoarding3,
      ),
    ];
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Builder(builder: (context) {
        return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is OnBoardingCompleted || state is OnBoardingSkipped) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: CustomNextButton(
                  pages: _pages, pageController: _pageController),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: AppColor.onBoardingColorsList,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        CustomSkipButton(onPressed: () {
                          context.read<OnBoardingCubit>().skipOnBoarding();
                        }),
                        PageViewBuilder(
                            pageController: _pageController, pages: _pages),
                        CustomSmoothPageIndicator(
                            pageController: _pageController, pages: _pages),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
