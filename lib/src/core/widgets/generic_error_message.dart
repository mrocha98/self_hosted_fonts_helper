import 'package:flutter/material.dart';

import '../locale/app_localizations.dart';

class GenericErrorMessage extends StatelessWidget {
  const GenericErrorMessage({
    super.key,
    this.retry,
  });

  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.close,
            color: Colors.red,
            size: Theme.of(context).textTheme.displayMedium?.fontSize,
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.genericErrorMessage,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: retry != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OutlinedButton.icon(
                onPressed: retry,
                icon: const Icon(Icons.replay_outlined),
                label: Text(AppLocalizations.of(context)!.retryActionText),
              ),
            ),
          )
        ],
      ),
    );
  }
}
