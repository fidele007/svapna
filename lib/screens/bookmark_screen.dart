import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:svapna/l10n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/providers/bookmarks_provider.dart';
import 'package:svapna/styles/styles.dart';
import 'package:svapna/widgets/search_app_bar.dart';

import 'dream_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = '/bookmarks';

  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen>
    with AutomaticKeepAliveClientMixin {
  final SearchController _searchController = SearchController();

  @override
  bool get wantKeepAlive => true;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isWide = MediaQuery.of(context).size.width >= 850;

    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case DreamDetailScreen.routeName:
            return MaterialPageRoute(
              builder: (context) => DreamDetailScreen(
                dream: settings.arguments as Dream,
              ),
            );
          case BookmarkScreen.routeName:
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: SearchAppBar(
                  searchController: _searchController,
                  title: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 8.0,
                    children: [
                      if (!isWide)
                        SvgPicture.asset(
                          'assets/svapna.svg',
                          width: 40,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                          semanticsLabel: AppLocalizations.of(context)!.appName,
                        ),
                      Text(
                        AppLocalizations.of(context)!.bookmarks,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                body: Consumer<BookmarksProvider>(
                  builder: (context, bookmarksProvider, child) {
                    List<Dream> bookmarkedDreams = bookmarksProvider.bookmarks;
                    return bookmarkedDreams.isEmpty
                        ? Center(
                            child: Text(
                                AppLocalizations.of(context)!.bookmarksEmpty))
                        : ListView.builder(
                            itemCount: bookmarkedDreams.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  bookmarkedDreams[index].name,
                                  style: AppStyle.listTitleStyle(context),
                                ),
                                subtitle: Text(
                                  bookmarkedDreams[index].plainTextDefinition ??
                                      '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.listSubtitleStyle(context),
                                ),
                                onTap: () {
                                  _navigatorKey.currentState!.pushNamed(
                                    DreamDetailScreen.routeName,
                                    arguments: bookmarkedDreams[index],
                                  );
                                },
                              );
                            },
                          );
                  },
                ),
              ),
            );
        }
      },
    );
  }
}
