import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../models/dream.dart';

class DreamDetail extends StatelessWidget {
  final Dream dream;

  const DreamDetail({super.key, required this.dream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          dream.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HtmlWidget(
            dream.definition,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
