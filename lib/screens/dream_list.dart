import 'package:flutter/material.dart';

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

  late final List<Dream> _allDreams;
  List<Dream> _filteredDreams = [];

  @override
  void initState() {
    super.initState();

    DreamService.dreams.then((completeDreamList) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('សប្តិ — Svapna'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor.bar(
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
              barHintText: 'ស្វែងរកសុបិន',
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
}
