import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/models/language.dart';
import 'package:svapna/providers/language_provider.dart';
import 'package:svapna/services/dream_service.dart';
import 'package:svapna/styles/styles.dart';

import 'dream_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final SearchController _searchController = SearchController();

  final double minSearchBarHeight = 50.0;

  List<Dream> _allDreams = [];
  List<Dream> _filteredDreams = [];

  @override
  void initState() {
    super.initState();

    loadDreams();
  }

  void loadDreams() {
    final languageCode = context.read<LanguageProvider>().locale.languageCode;
    DreamService.getDreams(languageCode).then((completeDreamList) {
      setState(() {
        _allDreams = completeDreamList;
        _filteredDreams =
            filterDreams(completeDreamList, _searchController.text.trim());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('សប្តិ — Svapna (WASM: $isRunningWithWasm)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                SearchAnchor.bar(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth: 600.0,
                    minHeight: minSearchBarHeight,
                  ),
                  onSubmitted: (value) {
                    final filteredDreams = filterDreams(_allDreams, value);
                    setState(() {
                      _filteredDreams = filteredDreams;
                      if (value.isNotEmpty) {
                        _searchController.closeView(value);
                      }
                    });
                  },
                  searchController: _searchController,
                  barHintText: AppLocalizations.of(context)!.searchDreams,
                  // barPadding: const WidgetStatePropertyAll<EdgeInsets>(
                  //     EdgeInsets.symmetric(horizontal: 16)),
                  suggestionsBuilder: (context, controller) {
                    return filterDreams(_allDreams, controller.text.trim())
                        .map((dream) => ListTile(
                              title: Text(dream.name),
                              onTap: () {
                                onDreamTap(dream);
                              },
                            ))
                        .toList();
                  },
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: Size(125, minSearchBarHeight + 5),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(12.0),
                    // ),
                  ),
                  onPressed: onLangButtonPressed,
                  icon: const Icon(Icons.translate_rounded),
                  label: Text(
                    context.read<LanguageProvider>().nextLocale.displayName,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredDreams.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.searchEmpty),
                  )
                : ListView.builder(
                    itemCount: _filteredDreams.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _filteredDreams[index].name,
                          style: AppStyle.listTitleStyle(context),
                        ),
                        subtitle: Text(
                          _filteredDreams[index].plainTextDefinition ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.listSubtitleStyle(context),
                        ),
                        onTap: () => onDreamTap(_filteredDreams[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  static List<Dream> filterDreams(List<Dream> dreamList, String query) {
    if (query.isEmpty || query.trim().isEmpty) {
      return dreamList;
    }

    final filteredDreams = dreamList
        .where((dream) => dream.name.toUpperCase().contains(
              query.toUpperCase(),
            ))
        .toList();

    return filteredDreams;
  }

  void onDreamTap(Dream dream) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DreamDetailScreen(dream: dream),
      ),
    );
  }

  void onLangButtonPressed() {
    final languageProvider = context.read<LanguageProvider>();
    languageProvider.setLocale(languageProvider.nextLocale);
    loadDreams();
  }
}
