import 'package:paper_cv/components/floor_buttons.dart';
import 'package:paper_cv/config/config.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorAppBarIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPressed;
  final String? tooltip;

  const FloorAppBarIconButton({super.key, required this.iconData, this.onPressed, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      padding: EdgeInsets.zero,
      icon: Icon(iconData, size: AppSizes.kIconSize),
      onPressed: onPressed,
    );
  }
}

class FloorAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Widget? title;
  final void Function()? customPop;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;

  FloorAppBar({
    this.title,
    this.customPop,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useDesktopLayout() => MediaQuery.of(context).size.width >= AppSizes.kDesktopWidth;
    final bool noRouteBelow = (ModalRoute.of(context) == null || (ModalRoute.of(context)!.isFirst));
    return AppBar(
      backgroundColor: backgroundColor ?? (useDesktopLayout() ? Theme.of(context).colorScheme.surfaceContainer : null),
      leadingWidth: 0,
      leading: SizedBox(),
      titleSpacing: AppSizes.kGap,
      centerTitle: false,
      title: (noRouteBelow && title == null)
          ? null
          : RowGap(
              gap: AppSizes.kSmallGap,
              children: [
                if (!noRouteBelow && showBackButton)
                  FloorTransparentButton(
                    iconData: Icons.chevron_left,
                    text: S.current.back,
                    onPressed: customPop ?? Navigator.of(context).pop,
                  ),
                if (title != null) Expanded(child: title!),
              ],
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.kComponentHeight + AppSizes.kSmallGap);
}
