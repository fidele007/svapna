import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:svapna/services/dream_service.dart';

import '../models/dream.dart';
import 'dream_detail.dart';

class DreamList extends StatefulWidget {
  const DreamList({super.key});

  @override
  State<DreamList> createState() => _DreamListState();
}

class _DreamListState extends State<DreamList> {
  List<Dream> dreams = [];

  @override
  void initState() {
    super.initState();

    DreamService.dreams.then((value) {
      setState(() {
        dreams = value;
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
      body: ListView.builder(
        itemCount: dreams.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              dreams[index].name,
              style: listTitleStyle,
            ),
            subtitle: Text(
              dreams[index].plainTextDefinition ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: listSubtitleStyle,
            ),
            onTap: () => onDreamTap(dreams[index]),
          );
        },
      ),
    );
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
