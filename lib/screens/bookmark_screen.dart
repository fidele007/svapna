import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/providers/bookmarks_provider.dart';
import 'package:svapna/styles/styles.dart';
import 'package:svapna/widgets/shared_app_bar.dart';

import 'dream_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: SharedAppBar(
        title: Text(
          AppLocalizations.of(context)!.bookmarks,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<BookmarksProvider>(
        builder: (context, bookmarksProvider, child) {
          List<Dream> bookmarkedDreams = bookmarksProvider.bookmarks;
          return bookmarkedDreams.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!.bookmarksEmpty))
              : ListView.builder(
                  itemCount: bookmarkedDreams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        bookmarkedDreams[index].name,
                        style: AppStyle.listTitleStyle(context),
                      ),
                      subtitle: Text(
                        bookmarkedDreams[index].plainTextDefinition ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.listSubtitleStyle(context),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DreamDetailScreen(
                                dream: bookmarkedDreams[index]),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
