import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/providers/history_provider.dart';
import 'package:svapna/styles/styles.dart';
import 'package:svapna/widgets/search_app_bar.dart';

import 'dream_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  final SearchController _searchController = SearchController();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isWide = MediaQuery.of(context).size.width >= 850;

    return Scaffold(
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
              AppLocalizations.of(context)!.history,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, child) {
          List<Dream> recentDreams = historyProvider.history;
          return recentDreams.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.historyEmpty))
              : ListView.builder(
                  itemCount: recentDreams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        recentDreams[index].name,
                        style: AppStyle.listTitleStyle(context),
                      ),
                      subtitle: Text(
                        recentDreams[index].plainTextDefinition ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.listSubtitleStyle(context),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DreamDetailScreen(dream: recentDreams[index]),
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
