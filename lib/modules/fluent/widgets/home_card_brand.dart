import 'package:fluent_ui/fluent_ui.dart';

class HomeCardBrand extends StatelessWidget {
  const HomeCardBrand ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: const Color(0xFF20242D),
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
      child: Column(
        children: [
          const Text('Made with love by',
            style: TextStyle(fontFamily: 'AminaReska', color: Colors.white, fontSize: 20)
          ),
          Image.asset('assets/brandwhite.png', width: 500.0, height: 100.0),
          const Text('Happy Hacking!, Dart... Dart..',
            style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          const SizedBox(height: 15),
          const Text('This UI is powered by',
            style: TextStyle(fontSize: 20, color: Colors.white)
          ),
          const SizedBox(height: 30),
          const Text('Fluent UI',
            style: TextStyle(fontSize: 60, color: Colors.white)
          ),
        ],
      )
    );
  }
}