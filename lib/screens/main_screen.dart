import 'package:cupcake_challenge/models/cupcake_model.dart';
import 'package:cupcake_challenge/utils/style.dart';
import 'package:cupcake_challenge/widget/app_padding.dart';
import 'package:cupcake_challenge/widget/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController rotationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  );
  late final Animation<double> rotationAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(rotationController);

  late final AnimationController slideController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  );
  late Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, 1.5),
    end: const Offset(0, -2),
  ).animate(slideController);

  late final AnimationController slideController2 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late Animation<Offset> slideAnimation2 = Tween<Offset>(
    begin: const Offset(0, -1.5),
    end: const Offset(0, 1.5),
  ).animate(slideController2);
  @override
  Widget build(BuildContext context) {
    final cupcakeList = CupCakeModel.getCupCakeList();
    final currentpage = useState(0);
    final pageController = usePageController(initialPage: 0);

    return Scaffold(
      body: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.center,
        color: cupcakeList[currentpage.value].backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 350,
              width: 250,
              decoration: BoxDecoration(
                color: Style.filledBackground,
                borderRadius: BorderRadius.circular(200),
              ),
            ),
            PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                currentpage.value = index;
              },
              itemCount: cupcakeList.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 110),
                      height: 200,
                      child: Image.asset(
                        cupcakeList[index].image ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: RotationTransition(
                            turns: rotationAnimation,
                            child: Image.asset(
                              cupcakeList[index].topping ?? '',
                              height: 130,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: SlideTransition(
                        position: slideAnimation2,
                        child: RotationTransition(
                          turns: rotationAnimation,
                          child: Image.asset(
                            cupcakeList[index].topping ?? '',
                            height: 130,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SafeArea(
                  child: AppPadding(
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.menu),
                            Spacer(),
                            Icon(Icons.search),
                            SizedBox(width: 16),
                            Icon(Icons.shopping_cart_outlined)
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 50,
                          width: 250,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Style.filledBackground,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Choose Your Favorite',
                            style: Style.mainFont.titleSmall?.copyWith(
                              color: Style.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: AppPadding(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ArrowButton(
                              isForward: false,
                              onPressed: () {
                                onCupcakePageChange(isForward: false);

                                pageController.animateToPage(
                                    duration: const Duration(milliseconds: 700),
                                    currentpage.value == 0
                                        ? cupcakeList.length - 1
                                        : currentpage.value - 1,
                                    curve: Curves.easeInOutSine);
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Style.filledBackground),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 16)),
                                  ),
                                  child: const Text('Add To Cart'),
                                ),
                              ),
                            ),
                            ArrowButton(
                              isForward: true,
                              onPressed: () {
                                onCupcakePageChange(isForward: true);
                                pageController.animateToPage(
                                    duration: const Duration(milliseconds: 700),
                                    currentpage.value == cupcakeList.length - 1
                                        ? 0
                                        : currentpage.value + 1,
                                    curve: Curves.easeInOutSine);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 12),
                            itemCount: cupcakeList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final cupcake = cupcakeList[index];
                              return SizedBox(
                                width: 60,
                                child: Column(
                                  children: [
                                    Image.asset(cupcake.image ?? '',
                                        height: 50, fit: BoxFit.cover),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(top: 16),
                                      width:
                                          currentpage.value == index ? 40 : 0,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onCupcakePageChange({required bool isForward}) async {
    rotationController.forward();
    slideController.forward();
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    slideController2.forward();

    rotationController
      ..reset()
      ..forward().then((value) async {
        await Future.delayed(
          const Duration(milliseconds: 300),
        );
        rotationController.reset();

        slideAnimation2 = Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 1.5),
        ).animate(slideController2);

        slideAnimation = Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: const Offset(0, -2),
        ).animate(slideController);

        slideController.reset();
        slideController2.reset();
      });
  }
}
