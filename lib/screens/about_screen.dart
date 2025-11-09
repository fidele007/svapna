import 'package:flutter/material.dart';

import 'package:svapna/i18n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'សប្តិ — Svapna',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'v1.0.0 (WASM: $isRunningWithWasm)',
                // style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16.0),
              Text(AppLocalizations.of(context)!.aboutApp1),
              const SizedBox(height: 8.0),
              Text(AppLocalizations.of(context)!.aboutApp2),
              Spacer(),
              Text(AppLocalizations.of(context)!.developedWithBy),
            ],
          ),
        ),
      ),
    );
  }
}
