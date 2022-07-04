import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/fluent/providers/theme_provider.dart';
import 'package:flutterfly/providers/providers.dart';
import 'package:flutterfly/modules/fluent/widgets/blur_button.dart';

class StoreCard extends StatefulWidget {
  const StoreCard({Key? key}) : super(key: key);

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {

  final storeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);

    return Card(
      backgroundColor: themeProvider.cardColor,
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
      child: Column(
        children: [
          const SizedBox(height: 45),
          Text('Write anything in this form and send!',
            style: TextStyle(color:themeProvider.invertedColor, fontSize: 20)
          ),
          const SizedBox(height: 30),
          _textField(),
          const SizedBox(height: 30),
          _button(context),
          const SizedBox(height: 45),
          _storeState(context),
          const SizedBox(height: 45)
        ]
      )
    );
  }
  SizedBox _textField() {
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);
    return SizedBox(
      width: 250.0,
      height: 40.0,
      child: TextBox(
        cursorHeight: 25,
        controller: storeController,
        placeholder: 'here',
        placeholderStyle: const TextStyle(color: Color(0xFF6B7280)),
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color:themeProvider.invertedColor),
        cursorColor:themeProvider.invertedColor,
        highlightColor: const Color(0xFF6B7280),
        decoration: BoxDecoration(color: themeProvider.cardColor),
      )
    );
  }

  BlurButton _button(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    return BlurButton(
      caption: 'Send',
      onClick: () {
        if (storeController.text.isNotEmpty) {
          dataProvider.rename(storeController.text);
          setState(() {});
        } else {
          showDialog (
            context: context,
            builder: (context) => ContentDialog(
              title: const Text('Error'),
              content: const Text('Is empty your Text'),
              actions: [Button (child: const Text('OK'), onPressed: () => Navigator.pop(context))]
            )
          );
        }
      }
    );
  }

  Text _storeState(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeFluentProvider>(context, listen: true);

    if (dataProvider.data.isEmpty) {
      return  Text('Store State: Not Yet', style: TextStyle(color:themeProvider.invertedColor, fontSize: 20));
    } else {
      return Text('Store state: Yes, you write. ${dataProvider.data}', style: TextStyle(color:themeProvider.invertedColor, fontSize: 20));
    }
  }
}