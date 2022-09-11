import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/core/widgets/app_background.dart';
import 'package:weatherapp/feature/bookmark/presentation/scressns/bookmark_screen.dart';
import 'package:weatherapp/feature/weather/presentation/scressns/home_screen.dart';

class RoootScreen extends StatefulWidget {
  const RoootScreen({Key? key}) : super(key: key);

  @override
  State<RoootScreen> createState() => _RoootScreenState();
}

const int homeIndex = 0;
const int bookmark = 1;

class _RoootScreenState extends State<RoootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _boomarkKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    bookmark: _boomarkKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'weather',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bookmark,
                ),
                label: 'Bookamrk cieties',
              ),
            ],
          ),
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, HomeScreen()),
              _navigator(_boomarkKey, bookmark, BookMarkScreen(
                onTap: () {
                  setState(() {
                    selectedScreenIndex = homeIndex;
                  });
                },
              )),
            ],
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
