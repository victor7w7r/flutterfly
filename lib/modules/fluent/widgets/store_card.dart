import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutterfly/modules/fluent/widgets/blur_button.dart';

class StoreCard extends StatefulWidget {
  const StoreCard({Key? key}) : super(key: key);

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: const Color(0xFF20242D),
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(150, 150, 150, 150),
      child: Column(
        children: [
          const SizedBox(height: 45),
          const Text('Write anything in this form and send!',
            style: TextStyle(color: Colors.white, fontSize: 20)
          ),
          const SizedBox(height: 45),
          BlurButton(caption: 'Send', onClick:() => {}),
          const SizedBox(height: 45),
          const Text('Store State: Not Yet',
            style: TextStyle(color: Colors.white, fontSize: 20)
          ),
        ],
      )
    );
  }
}