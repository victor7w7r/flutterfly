import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart';
import 'package:flutterfly/modules/material/widgets/widgets.dart';

class StoreScreen extends StatefulWidget {

  static const String routerName = 'Store';

  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  final storeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Store'), elevation: 0.0),
        drawer: DrawerMenu(callback: () => setState((){})),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text('Store Example', style: TextStyle(fontSize: 40))),
            const SizedBox(height: 15),
            const Center(
              child: Text('Write anything in this form and send!', style: TextStyle(fontSize: 20))
            ),
            const SizedBox(height: 25),
            _textField(),
            const SizedBox(height: 12),
            _button(context),
            const SizedBox(height: 10),
            _storeState(context)
          ]
        )
      )
    );
  }

  SizedBox _textField() {
    return SizedBox(
      width: 250.0,
      height: 55.0,
      child: TextField(
        cursorHeight: 25,
        controller: storeController,
        decoration: const InputDecoration(
          hintText: 'here',
          border: OutlineInputBorder()
        )
      )
    );
  }

  SizedBox _button(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          if (storeController.text.isNotEmpty) {
            dataProvider.rename(storeController.text);
            setState(() {});
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Is empty your TextField'),
                actions: [TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK'))]
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
      return const Center(child: Text('Store state: Not yet.', style: TextStyle(fontSize: 20)));
    } else {
      return Center(child: Text("Store state: Yes, you write. ${dataProvider.data}", style: const TextStyle(fontSize: 20)));
    }
  }
}