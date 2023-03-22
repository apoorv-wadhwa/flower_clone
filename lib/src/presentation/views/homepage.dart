import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:store/src/core/constants/constants_import.dart';

import '../../core/constants/animation_constants.dart';
import '../widgets/custom/cstom_wave_clipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var _selectedIndex = 0;
  Animation<double>? _bottomNavBarHeightAnimation;
  Animation<double>? _bottomNavBarWidthAnimation;
  Animation<double>? _bottomNavBarBorderAnimation;
  AnimationController? _bottomNavBarHeightAndWidthAnimationController;
  AnimationController? _bottomNavBarBorderAnimationController;
  Animation<double>? _tabBarWidthAnimation;
  Animation<double>? _tabBarBorderAnimation;
  AnimationController? _tabBarHeightAndWidthAnimationController;
  AnimationController? _tabBarBorderAnimationController;
  Animation<Offset>? _listSlideTransitionAnimation;
  AnimationController? _listSlideAnimationController;
  Animation<Offset>? _popularRowSlideTransitionAnimation;
  AnimationController? _popularRowSlideAnimationController;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tabController = TabController(
        length: 4,
        vsync: this,
      );
      _setUpListAnimation();
      _setUpSlideRowAnimation();
      _setUpTabBarAnimations();
      _setUpBottomNavBarAnimations();
      // _setUpListAnimation();
    });
  }

  void _setUpBottomNavBarAnimations() {
    _bottomNavBarHeightAndWidthAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _bottomNavBarBorderAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    );
    _bottomNavBarHeightAnimation =
        Tween<double>(begin: 0.0, end: 40).animate(CurvedAnimation(
      parent: _bottomNavBarHeightAndWidthAnimationController!,
      curve: Curves.ease,
    ))
          ..addListener(() {
            setState(() {});
          });
    _bottomNavBarWidthAnimation =
        Tween<double>(begin: 80, end: MediaQuery.of(context).size.width - 40)
            .animate(CurvedAnimation(
      parent: _bottomNavBarHeightAndWidthAnimationController!,
      curve: Curves.ease,
    ))
          ..addStatusListener((status) {
            setState(() {});
            if (status == AnimationStatus.completed) {
              _bottomNavBarBorderAnimationController!.forward();
            }
          });
    _bottomNavBarBorderAnimation =
        Tween<double>(begin: 0.0, end: 25).animate(CurvedAnimation(
      parent: _bottomNavBarBorderAnimationController!,
      curve: Curves.ease,
    ))
          ..addListener(() {
            setState(() {});
          });
    _bottomNavBarHeightAndWidthAnimationController!.forward();
  }

  void _setUpTabBarAnimations() {
    _tabBarHeightAndWidthAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _tabBarBorderAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _tabBarWidthAnimation =
        Tween<double>(begin: 0.0, end: 30).animate(CurvedAnimation(
      parent: _tabBarHeightAndWidthAnimationController!,
      curve: Curves.ease,
    ))
          ..addStatusListener((status) {
            setState(() {});
            if (status == AnimationStatus.completed) {
              _tabBarBorderAnimationController!.forward();
              _listSlideAnimationController!.forward();
            }
          });

    _tabBarBorderAnimation =
        Tween<double>(begin: 0.0, end: 25).animate(CurvedAnimation(
      parent: _tabBarBorderAnimationController!,
      curve: Curves.ease,
    ))
          ..addListener(() {
            setState(() {});
          });
    _tabBarHeightAndWidthAnimationController!.forward();
  }

  void _setUpListAnimation() {
    _listSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _listSlideTransitionAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _listSlideAnimationController!, curve: Curves.easeIn),
    )..addListener(() {
        setState(() {});
      });
  }

  void _setUpSlideRowAnimation() {
    _popularRowSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _popularRowSlideTransitionAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _listSlideAnimationController!, curve: Curves.easeIn),
    )..addListener(() {
        setState(() {});
      });

    _popularRowSlideAnimationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              buildBackgroundImage(),
              _buildLeafAnimation(),
              _buildAppBarText(),
              _buildAppBarIcons(),
              Container(
                margin: const EdgeInsets.only(
                  top: Dimensions.px30,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.px100,
                      ),
                      _buildNavigationRail(),
                      const SizedBox(
                        height: Dimensions.px20,
                      ),
                      _buildPopularFlowers(),
                      const SizedBox(
                        height: Dimensions.px10,
                      ),
                      _buildFlowersButtons(),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    _buildBottomNavBar(),
                    const SizedBox(
                      height: Dimensions.px10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildPopularFlowers() {
    return _popularRowSlideTransitionAnimation != null
        ? SlideTransition(
            position: _popularRowSlideTransitionAnimation!,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.px15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular Flowers",
                      style: AppTextStyles.boldText(
                          fontSize: 20, color: ColorConstants.black)),
                  Container(
                    height: 35,
                    width: 100,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffF6ECDE),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text("See All",
                          style: AppTextStyles.boldText(
                              color: ColorConstants.butterCup, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildFlowersButtons() {
    return _listSlideTransitionAnimation != null
        ? SlideTransition(
            position: _listSlideTransitionAnimation!,
            child: SizedBox(
              height: Dimensions.px200,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => Container(
                        height: Dimensions.px40,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                IconConstants.birthday,
                                fit: BoxFit.fitWidth,
                                height: 95,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.px20,
                              ),
                            )
                          ],
                        ),
                      )),
            ),
          )
        : Container();
  }

  Widget _buildAppBarText() {
    return Positioned(
        left: Dimensions.px15,
        top: Dimensions.px15,
        child: Text(
          'Flower\nShop',
          style: AppTextStyles.regularText(
              fontSize: Dimensions.px40, color: ColorConstants.white),
        ));
  }

  Widget _buildAppBarIcons() {
    return Positioned(
      right: Dimensions.px15,
      top: Dimensions.px15,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: ColorConstants.white,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: ColorConstants.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeafAnimation() {
    return Positioned(
      //  duration: Duration(milliseconds: 600),
      top: -100,
      right: -50,
      child: Container(
        height: 450,
        width: 200,
        child: FlareActor(
          AnimationConstants.leafAnimation,
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          animation: "success",
          controller: FlareControls(),
        ),
      ),
    );
  }

  Widget buildBackgroundImage() {
    return ClipPath(
      clipper: CustomWaveClipperOne(),
      child: Container(
        height: Dimensions.px250,
        width: double.infinity,
        child: Image.asset(
          ImageConstants.backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNavigationRail() {
    return SizedBox(
      height: Dimensions.px350,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: _tabBarWidthAnimation?.value ?? 0.0,
                height: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(_tabBarBorderAnimation?.value ?? 0.0),
                  bottomRight:
                      Radius.circular(_tabBarBorderAnimation?.value ?? 0.0),
                )),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: _tabController != null
                      ? TabBar(
                          // isScrollable: true,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          onTap: (value) {
                            // setState(() {
                            //   _tabController!.index = value;
                            // });
                            setState(() {});
                            _listSlideAnimationController!.reset();
                            _listSlideAnimationController!.forward();
                          },

                          tabs: const [
                            Tab(
                              child: Text(
                                StringConstants.bouquet,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                StringConstants.wedding,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                StringConstants.rose,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                StringConstants.basket,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                          indicatorColor: ColorConstants.butterCup,
                          indicatorWeight: 5,
                          // indicator: const UnderlineTabIndicator(
                          //   borderSide: BorderSide(width: 5.0),
                          //   // insets: EdgeInsets.symmetric(horizontal: 5),
                          // ),
                        )
                      : Container(),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
          const SizedBox(
            width: Dimensions.px20,
          ),
          Expanded(
            child: Container(
              child: _listSlideTransitionAnimation != null
                  ? SlideTransition(
                      position: _listSlideTransitionAnimation!,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          height: Dimensions.px350,
                          child: Card(
                            elevation: 2.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 200,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      ImageConstants.weddingFlowers,
                                      fit: BoxFit.fill,
                                      width: 180,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.px20,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: '\nWedding Bouquet : ',
                                          style: AppTextStyles.boldText(),
                                          children: [
                                        TextSpan(
                                          text: 'Sunflower',
                                          style: AppTextStyles.boldText(
                                            color: ColorConstants.green,
                                          ),
                                        ),
                                      ])),
                                  const SizedBox(
                                    height: Dimensions.px10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorConstants.green),
                                          child: Text(
                                            'Add to Cart',
                                            style: AppTextStyles.semiBoldText(
                                              color: ColorConstants.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: Dimensions.px10,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorConstants.green),
                                          child: Text(
                                            'Buy Now',
                                            style: AppTextStyles.semiBoldText(
                                              color: ColorConstants.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        itemCount: 10,
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() => Container(
        height: _bottomNavBarHeightAnimation?.value ?? 0.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(_bottomNavBarBorderAnimation?.value ?? 0.0)),
          color: ColorConstants.butterCup,
        ),
        width: _bottomNavBarWidthAnimation?.value ?? 0.0,
        child: (_bottomNavBarWidthAnimation?.value ?? 0.0) > 200
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    IconConstants.homePng,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    color: ColorConstants.white,
                  ),
                  Image.asset(
                    IconConstants.likePng,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    color: ColorConstants.white,
                  ),
                  InkWell(
                    child: Image.asset(
                      IconConstants.shoppingCartPng,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      color: ColorConstants.white,
                    ),
                  ),
                  Image.asset(
                    IconConstants.manPng,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    color: ColorConstants.white,
                  ),
                ],
              )
            : Container(
                color: Colors.white,
              ),
      );
}
