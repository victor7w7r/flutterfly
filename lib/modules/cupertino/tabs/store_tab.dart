import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart';

import 'package:flutterfly/modules/cupertino/widgets/widgets.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({Key? key}) : super(key: key);

  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {

  final storeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            right: 0,
            child: ThemeToggle()
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: Text('Store Example', style: TextStyle(fontSize: 40))),
              const SizedBox(height: 15),
              const Center(
                child: Text('Write anything in this form and send!', style: TextStyle(fontSize: 20))
              ),
              const SizedBox(height: 25),
              _textField(context),
              const SizedBox(height: 12),
              _button(context),
              const SizedBox(height: 20),
              _storeState(context)
            ]
          )
        ],
      )
    );
  }

  SizedBox _textField(BuildContext context) {

    final themeProvider = Provider.of<CupertinoProvider>(context, listen: true);

    return SizedBox(
      width: 250.0,
      height: 55.0,
      child: CupertinoTextField(
        placeholder: 'here',
        cursorHeight: 25,
        controller: storeController,
        decoration: BoxDecoration(
          color: themeProvider.darkMode
            ?const Color(0xFF262626)
            : const Color(0xFFF5F5F5),
        )
      )
    );
  }

  SizedBox _button(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    return SizedBox(
      child: CupertinoButton.filled(
        onPressed: () {
          if (storeController.text.isNotEmpty) {
            dataProvider.rename(storeController.text);
            setState(() {});
          } else {
            showCupertinoModalPopup<void> (
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog (
                title: const Text('Error'),
                content: const Text('Is empty your TextField'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK')
                  )
                ]
              )
            );
          }
        },
        child: const Text('SUBMIT')
      )
    );
  }

  Center _storeState(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (dataProvider.data.isEmpty) {
      return const Center(
        child: Text('Store state: Not yet.', style: TextStyle(fontSize: 15) )
      );
    } else {
      return Center(
        child: Text("Store state: Yes, you write. ${dataProvider.data}", style: const TextStyle(fontSize: 15))
      );
    }
  }
}