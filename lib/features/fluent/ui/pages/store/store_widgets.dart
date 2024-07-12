import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

final class StoreText extends StatelessWidget {
  const StoreText({
    required this.ctl,
    required this.theme,
    super.key,
  });

  final TextEditingController ctl;
  final FluentThemeApp theme;

  @override
  Widget build(
    final BuildContext context,
  ) =>
      SizedBox(
        width: 250.0,
        height: 40.0,
        child: TextBox(
          controller: ctl,
          decoration: BoxDecoration(color: theme.themeColor[1]),
          highlightColor: const Color(0xFF6B7280),
          placeholder: 'here',
          placeholderStyle: const TextStyle(color: Color(0xFF6B7280)),
          style: TextStyle(color: theme.themeColor[2]),
          textAlignVertical: TextAlignVertical.center,
          cursorHeight: 25,
          cursorColor: theme.themeColor[2],
        ),
      );
}
