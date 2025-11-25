import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'package:svapna/l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? _version;

  @override
  void initState() {
    super.initState();

    _loadVersion();
  }

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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                'v$_version (WASM: $isRunningWithWasm)',
                // style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.aboutApp1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8.0),
              Text(
                AppLocalizations.of(context)!.aboutApp2,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Spacer(),
              Text(AppLocalizations.of(context)!.developedWithBy),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}+${info.buildNumber}';
    });
  }
}
