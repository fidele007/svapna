import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:svapna/models/dream.dart';
import 'package:svapna/models/shared_prefs.dart';
import 'package:svapna/providers/bookmarks_provider.dart';
import 'package:svapna/providers/history_provider.dart';

class DreamDetailScreen extends StatefulWidget {
  static const routeName = '/dream-detail';

  final Dream dream;

  const DreamDetailScreen({super.key, required this.dream});

  @override
  State<DreamDetailScreen> createState() => _DreamDetailScreenState();
}

class _DreamDetailScreenState extends State<DreamDetailScreen> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();

    isBookmarked = SharedPrefs.instance.isDreamBookmarked(widget.dream);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false)
          .addHistory(widget.dream);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SelectableText(
            widget.dream.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (isBookmarked) {
                  await Provider.of<BookmarksProvider>(context, listen: false)
                      .removeBookmark(widget.dream);
                } else {
                  await Provider.of<BookmarksProvider>(context, listen: false)
                      .addBookmark(widget.dream);
                }
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
              icon: isBookmarked
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_outline),
            ),
            IconButton(
              onPressed: () {
                SharePlus.instance.share(
                  ShareParams(
                    subject: widget.dream.name,
                    text: widget.dream.plainTextDefinition,
                  ),
                );
              },
              icon: const Icon(Icons.share_outlined),
            ),
            // TODO: Add share image with app watermark
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SelectionArea(
            child: HtmlWidget(
              widget.dream.definition,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
