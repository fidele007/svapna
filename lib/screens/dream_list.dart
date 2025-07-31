import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svapna/l10n/app_localizations.dart';
import 'package:svapna/models/language.dart';

import '../models/dream.dart';
import '../services/dream_service.dart';

import 'dream_detail.dart';

class DreamList extends StatefulWidget {
  const DreamList({super.key});

  @override
  State<DreamList> createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
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
    final listTitleStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.bold);

    final listSubtitleStyle = Theme.of(context).textTheme.bodyLarge;

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
            child: ListView.builder(
              itemCount: _filteredDreams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _filteredDreams[index].name,
                    style: listTitleStyle,
                  ),
                  subtitle: Text(
                    _filteredDreams[index].plainTextDefinition ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: listSubtitleStyle,
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
        builder: (context) => DreamDetail(dream: dream),
      ),
    );
  }

  void onLangButtonPressed() {
    final languageProvider = context.read<LanguageProvider>();
    languageProvider.setLocale(languageProvider.nextLocale);
    loadDreams();
  }
}
