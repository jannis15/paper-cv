import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/components/floor_card.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:paper_cv/utils/shadow_utils.dart';
import 'package:paper_cv/utils/widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class FloorContactBanner extends StatefulWidget {
  final void Function() onCloseBanner;

  const FloorContactBanner({super.key, required this.onCloseBanner});

  @override
  State<FloorContactBanner> createState() => _FloorContactBannerState();
}

class _FloorContactBannerState extends State<FloorContactBanner> {
  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      isShowing: Theme.of(context).brightness == Brightness.light,
      child: FloorCard(
        usePadding: false,
        child: SizedBox(
          width: 800,
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: -200,
                left: -200,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.secondary.withOpacity(.3),
                  ),
                  child: const SizedBox(height: 400, width: 400),
                ),
              ),
              Positioned(
                bottom: -250,
                left: -250,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.secondary.withOpacity(.3)),
                  child: const SizedBox(height: 500, width: 500),
                ),
              ),
              ColumnGap(
                mainAxisSize: MainAxisSize.min,
                gap: AppSizes.kGap,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Moin!', style: textTheme.headlineMedium),
                  Text("Gefällt Ihnen was Sie sehen?\nKontaktieren Sie mich!", style: textTheme.titleMedium),
                  RowGap(
                    gap: AppSizes.kSmallGap,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloorOutlinedButton(
                        iconData: FontAwesomeIcons.linkedin,
                        text: 'LinkedIn',
                        onPressed: () => launchUrl(Uri.parse('https://www.linkedin.com/in/jannis-brake-710a662a2/')),
                      ),
                      FloorOutlinedButton(
                        iconData: FontAwesomeIcons.github,
                        text: 'GitHub',
                        onPressed: () => launchUrl(Uri.parse('https://github.com/Jannis15/')),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  tooltip: 'Schließen',
                  icon: Icon(Icons.close),
                  onPressed: widget.onCloseBanner,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
