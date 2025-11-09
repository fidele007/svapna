import 'package:flutter/material.dart';

import 'package:svapna/l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'សប្តិ — Svapna',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'v1.0.0',
              // style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16.0),
            Text(AppLocalizations.of(context)!.aboutApp1),
            const SizedBox(height: 8.0),
            Text(AppLocalizations.of(context)!.aboutApp2),
            Spacer(),
            Text('Developed with 💖 by Force Fidele KIEN'),
          ],
        ),
      ),
    );
  }
}
