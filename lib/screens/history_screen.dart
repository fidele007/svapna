import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/providers/history_provider.dart';
import 'package:svapna/styles/styles.dart';
import 'package:svapna/widgets/shared_app_bar.dart';

import 'dream_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: SharedAppBar(
        title: Text(
          AppLocalizations.of(context)!.history,
          style: const TextStyle(fontWeight: FontWeight.w600),
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
