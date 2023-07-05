import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutterfly/features/fluent/providers/fluent_provider.dart';

final class StoreText extends StatelessWidget {

  final TextEditingController ctl;
  final FluentThemeApp theme;

  const StoreText({
    super.key,
    required this.ctl,
    required this.theme
  });

  @override
  Widget build(context) => SizedBox(
    width: 250.0,
    height: 40.0,
    child: TextBox(
      cursorHeight: 25,
      controller: ctl,
      placeholder: 'here',
      placeholderStyle: const TextStyle(
        color: Color(0xFF6B7280)
      ),
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: theme.themeColor[2]),
      cursorColor: theme.themeColor[2],
      highlightColor: const Color(0xFF6B7280),
      decoration: BoxDecoration(
        color: theme.themeColor[1]
      )
    )
  );
}