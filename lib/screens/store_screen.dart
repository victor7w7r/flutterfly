import 'package:flutter/material.dart';
import 'package:flutterfly/providers/data_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_menu.dart';

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

    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Store'),
          elevation: 0.0
        ),
        drawer: const DrawerMenu(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text('Store Example', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text('Write anything in this form and send!', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 250.0,
              height: 55.0,
              child: TextField( 
                cursorHeight: 25,
                controller: storeController,
                decoration: const InputDecoration(
                  hintText: 'here',
                  border: OutlineInputBorder(),
                )
              )
            ),
            const SizedBox(height: 12),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  if ( storeController.text.isNotEmpty ) {
                    dataProvider.rename(storeController.text);
                    setState(() {});
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Is empty your TextField'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK')
                          )
                        ]
                      )
                    );
                  }
                },
                child: const Text('SUBMIT'),
              )
            ),
            const SizedBox(height: 10),
            dataProvider.data!.isEmpty ? (
              const Center(  
                child: Text('Store state: Not yet.', style: TextStyle(fontSize: 20)),
              )
            ) : (
              Center(  
                child: Text("Store state: Yes, you write. ${dataProvider.data}", style: const TextStyle(fontSize: 20)),
              )
            )
          ]
        )
      )
    );
  }
}