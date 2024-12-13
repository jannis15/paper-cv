import 'package:flutter/material.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';

class FloorInfoScreen extends StatefulWidget {
  const FloorInfoScreen({super.key});

  @override
  State<FloorInfoScreen> createState() => _FloorInfoScreenState();
}

class _FloorInfoScreenState extends State<FloorInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(AppSizes.kGap),
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.kGap),
          child: ColumnGap(
            gap: AppSizes.kGap,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Über PaperCV',
                style: textTheme.titleLarge,
                textAlign: TextAlign.justify,
              ),
              Text(
                'PaperCV ist eine App zur Digitalisierung von A4-Dokumenten, die sich auf das Auslesen und Analysieren von Tabellen spezialisiert hat. Mit Hilfe von Machine Learning und Handschrifterkennung können Tabelleninhalte aus gescannten Dokumenten extrahiert und in einer neuen, klar strukturierten PDF-Datei gespeichert werden.',
                textAlign: TextAlign.justify,
                style: textTheme.bodyMedium,
              ),
              ColumnGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Aktuelle Funktionen:',
                    textAlign: TextAlign.justify,
                    style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '• Scannen von A4-Dokumenten mit der Kamera.',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    '• Erkennung von Handschrift und maschinell gedrucktem Text.',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    '• Erstellung einer optimierten PDF-Datei.',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
              ColumnGap(
                gap: AppSizes.kSmallGap,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Geplante Erweiterungen:',
                    textAlign: TextAlign.justify,
                    style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Zukünftig wird die App auch die Möglichkeit bieten, Tabellenkalkulationen zu erstellen und automatisch fehlende Informationen zu berechnen, um manuelle Arbeit zu reduzieren.',
                    textAlign: TextAlign.justify,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
