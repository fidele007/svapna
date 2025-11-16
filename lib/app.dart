import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/screens/about_screen.dart';
import 'package:svapna/screens/bookmark_screen.dart';
import 'package:svapna/screens/history_screen.dart';
import 'package:svapna/screens/home_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = <Widget>[
      const HomeScreen(),
      const HistoryScreen(),
      const BookmarkScreen(),
      const AboutScreen(),
    ];

    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 850;
    final shouldExtend = MediaQuery.of(context).size.width >= 1500;

    return Scaffold(
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              extended: shouldExtend,
              minExtendedWidth: 250,
              leading: Wrap(
                spacing: 5.0,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/svapna.svg',
                    width: 45,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  if (shouldExtend)
                    Text(
                      AppLocalizations.of(context)!.appName,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                ],
              ),
              useIndicator: true,
              labelType: shouldExtend
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text(AppLocalizations.of(context)!.home),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: Text(AppLocalizations.of(context)!.history),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: Text(AppLocalizations.of(context)!.bookmarks),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: Text(AppLocalizations.of(context)!.about),
                ),
              ],
              selectedIndex: _currentPageIndex,
              onDestinationSelected: onDestinationSelected,
            ),
          if (isWide) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              onDestinationSelected: onDestinationSelected,
              selectedIndex: _currentPageIndex,
              destinations: <NavigationDestination>[
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: AppLocalizations.of(context)!.home,
                ),
                NavigationDestination(
                  icon: Icon(Icons.history_outlined),
                  selectedIcon: Icon(Icons.history),
                  label: AppLocalizations.of(context)!.history,
                ),
                NavigationDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: AppLocalizations.of(context)!.bookmarks,
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: AppLocalizations.of(context)!.about,
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void onDestinationSelected(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}
