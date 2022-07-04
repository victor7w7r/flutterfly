import 'package:fluent_ui/fluent_ui.dart';

class HomeCardCrypto extends StatefulWidget {
  const HomeCardCrypto({Key? key}) : super(key: key);

  @override
  State<HomeCardCrypto> createState() => _HomeCardCryptoState();
}

class _HomeCardCryptoState extends State<HomeCardCrypto> {
  @override
  Widget build(BuildContext context) {
    return Card(
      backgroundColor: const Color(0xFF20242D),
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.fromLTRB(150, 150, 150, 150),
      child: Column(
        children: const [
          SizedBox(height: 45),
          Text('Store State: Not Yet',
            style: TextStyle(color: Colors.white, fontSize: 20)
          ),
          SizedBox(height: 45),
          Text('Symbol',
            style: TextStyle(color: Colors.white, fontSize: 20)
          ),
          Text('Price',
            style: TextStyle(color: Colors.white, fontSize: 20)
          ),
          SizedBox(height: 45)
        ],
      )
    );
  }
}