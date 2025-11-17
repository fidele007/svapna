import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:svapna/i18n/app_localizations.dart';
import 'package:svapna/models/dream.dart';
import 'package:svapna/providers/language_provider.dart';
import 'package:svapna/services/dream_service.dart';
import 'package:svapna/styles/styles.dart';
import 'package:svapna/widgets/search_app_bar.dart';

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

  List<Dream> _allDreams = [];
  List<Dream> _filteredDreams = [];

  final SearchController _searchController = SearchController();

  late final LanguageProvider languageProvider;

  @override
  void initState() {
    super.initState();

    loadDreams();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      languageProvider = context.read<LanguageProvider>();
      languageProvider.addListener(onLanguageChanged);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isWide = MediaQuery.of(context).size.width >= 850;

    return Scaffold(
      appBar: SearchAppBar(
        searchController: _searchController,
        title: isWide
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SvgPicture.asset(
                  'assets/svapna.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                  semanticsLabel: AppLocalizations.of(context)!.appName,
                ),
              ),
        onSearch: (value) {
          final filteredDreams = filterDreams(_allDreams, value);
          setState(() {
            _filteredDreams = filteredDreams;
          });
        },
        onSuggestions: (context, controller) {
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
      body: Column(
        children: [
          Expanded(
            child: _filteredDreams.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.searchEmpty),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 800.0),
                      child: ListView.builder(
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

  void loadDreams() {
    final languageCode = context.read<LanguageProvider>().locale.languageCode;
    DreamService.getDreams(languageCode).then((completeDreamList) {
      setState(() {
        _allDreams = completeDreamList;
        _filteredDreams = filterDreams(
          completeDreamList,
          _searchController.text.trim(),
        );
      });
    });
  }

  void onDreamTap(Dream dream) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DreamDetailScreen(dream: dream),
      ),
    );
  }

  @override
  void dispose() {
    languageProvider.removeListener(onLanguageChanged);
    languageProvider.dispose();

    super.dispose();
  }

  void onLanguageChanged() {
    loadDreams();
  }
}
