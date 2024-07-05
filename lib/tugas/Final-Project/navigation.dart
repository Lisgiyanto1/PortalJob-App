import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/tugas/Final-Project/home_screen.dart';
import 'package:flutter_app/tugas/Final-Project/pallete/colorpallate.dart';
import 'package:flutter_app/tugas/Final-Project/widget/profile_page.dart';
import 'package:flutter_app/tugas/Final-Project/widget/explore_page.dart'; // Add this line

class NavigationBarScreen extends StatefulWidget {
  final User? user;

  const NavigationBarScreen({Key? key, this.user}) : super(key: key);

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  bool _isFabVisible = true;
  late ScrollController _scrollController;

  static _NavigationBarScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<_NavigationBarScreenState>()!;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_pageListener);
    _scrollController = ScrollController();

    // Using _onScroll() as the listener for ScrollController
    _scrollController.addListener(_onScroll);

    _pages = [
      NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.depth == 0 &&
              notification.direction == ScrollDirection.forward) {
            // Show FAB on up scroll
            _showFab();
          } else if (notification.depth == 0 &&
              notification.direction == ScrollDirection.reverse) {
            // Hide FAB on down scroll
            _hideFab();
          }
          return true;
        },
        child: HomeScreen(),
      ),
      ExplorePage(), // Add this line
      ProfilePage(),
    ];
  }

  void _pageListener() {
    if (_pageController.page == 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else if (_pageController.page == 1) {
      setState(() {
        _currentIndex = 1;
      });
    } else if (_pageController.page == 2) {
      setState(() {
        _currentIndex = 2;
      });
    }
  }

  void _onScroll() {
    // Update _isFabVisible based on scroll position
    _isFabVisible = (_scrollController.offset <= 0); // Only show FAB at the top
    setState(() {});
  }

  void _showFab() {
    setState(() {
      _isFabVisible = true;
    });
  }

  void _hideFab() {
    setState(() {
      _isFabVisible = false;
    });
  }

  List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        itemCount: _pages.length,
        itemBuilder: (context, index) => _pages[index],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedOpacity(
        opacity: _isFabVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: 210,
          height: 75,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 2.0,
                blurRadius: 30.0,
                color: ColorPallete.primaryColor,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: FloatingActionButton(
                  heroTag: 'fab1',
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                      _pageController.animateToPage(
                        _currentIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    });
                  },
                  child: Icon(
                    Icons.home,
                    color: _currentIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  backgroundColor: Colors.white,
                  focusElevation: 8.0,
                  hoverElevation: 8.0,
                  shape: CircleBorder(),
                  splashColor: ColorPallete.slider,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                  heroTag: 'fab2',
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                      _pageController.animateToPage(
                        _currentIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    });
                  },
                  child: Icon(
                    Icons.explore, // Change this line
                    color: _currentIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  backgroundColor: Colors.white,
                  focusElevation: 8.0,
                  hoverElevation: 8.0,
                  shape: CircleBorder(),
                  splashColor: ColorPallete.slider,
                ),
              ),
              FloatingActionButton(
                heroTag: 'fab3',
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                    _pageController.animateToPage(
                      _currentIndex,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  });
                },
                child: Icon(
                  Icons.person,
                  color: _currentIndex == 2 ? Colors.black : Colors.grey,
                ),
                backgroundColor: Colors.white,
                focusElevation: 8.0,
                hoverElevation: 8.0,
                shape: CircleBorder(),
                splashColor: ColorPallete.slider,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers to prevent memory leaks
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
