import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jot_do/features/on_boarding/presentation/manager/cubits/onBoarding/on_boarding_cubit.dart';
import 'package:jot_do/features/on_boarding/presentation/widgets/on_boarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/on_boarding_model.dart';
import '../widgets/custom_skip_button.dart';

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
        image: AppConstants.imageOnBoardingPath1,
      ),
      OnBoardingModel(
        title: S.of(context).onBoardingTitle2,
        description: S.of(context).onBoardingDesc2,
        image: AppConstants.imageOnBoardingPath2,
      ),
      OnBoardingModel(
        title: S.of(context).onBoardingTitle3,
        description: S.of(context).onBoardingDesc3,
        image: AppConstants.imageOnBoardingPath3,
      ),
    ];
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Builder(builder: (context) {
        return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is OnBoardingCompleted) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            }
            if (state is OnBoardingSkipped) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: CustomNextButton(
                  pages: _pages, pageController: _pageController),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [
                        Color(0xffa724ec),
                        Colors.white,
                      ]),
                ),
                child: Column(
                  children: [
                    CustomSkipButton(onPressed: () {
                      context.read<OnBoardingCubit>().skipOnBoarding();
                    }),
                    PageViewBuilder(
                        pageController: _pageController, pages: _pages),
                    SizedBox(
                      height: 50,
                    ),
                    CustomIndicator(
                        pageController: _pageController, pages: _pages),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({
    super.key,
    required List<OnBoardingModel> pages,
    required PageController pageController,
  })  : _pages = pages,
        _pageController = pageController;

  final List<OnBoardingModel> _pages;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    double progress = (context.read<OnBoardingCubit>().currentIndex + 1) / 3;
    return GestureDetector(
      onTap: () {
        final cubit = context.read<OnBoardingCubit>();
        int nextIndex = cubit.currentIndex + 1;

        if (nextIndex < _pages.length) {
          _pageController.animateToPage(
            nextIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          cubit.onPageChanged(nextIndex);
        } else {
          cubit.completeOnBoarding();
        }
      },
      child: CircularPercentIndicator(
        radius: 30.0,
        lineWidth: 4.0,
        percent: progress,
        animation: true,
        animationDuration: 300,
        center: Icon(
          Icons.arrow_forward_ios,
          color: AppConstants.colorScheme,
          size: 18,
        ),
        progressColor: AppConstants.colorScheme,
        backgroundColor: Colors.white.withOpacity(0.3),
      ),
    );
  }
}

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    super.key,
    required PageController pageController,
    required List<OnBoardingModel> pages,
  })  : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<OnBoardingModel> _pages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          context.read<OnBoardingCubit>().onPageChanged(index);
        },
        itemBuilder: (context, index) {
          final page = _pages[index];
          return buildOnBoardingPage(
            context,
            title: page.title,
            description: page.description,
            image: page.image,
          );
        },
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required PageController pageController,
    required List<OnBoardingModel> pages,
  })  : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<OnBoardingModel> _pages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          onDotClicked: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          },
          count: _pages.length,
          effect: WormEffect(
              spacing: 8.0,
              dotHeight: 15,
              dotWidth: 15,
              dotColor: Colors.white70,
              activeDotColor: AppConstants.colorScheme),
        ),
      ),
    );
  }
}
