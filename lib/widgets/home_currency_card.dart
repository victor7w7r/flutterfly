import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show ThemeMaterialProvider;

class HomeCurrencyCard extends StatefulWidget {
  const HomeCurrencyCard({
    Key? key,
    required this.sym,
    required this.per,
    required this.pri,
    required this.orientation
  }): super(key: key);

  final String sym;
  final String per;
  final String pri;
  final Orientation orientation;

  @override
  State<HomeCurrencyCard> createState() => _HomeCurrencyCardState();
}

class _HomeCurrencyCardState extends State<HomeCurrencyCard> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeMaterialProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: themeProvider.darkState
          ? Border.all(width: 2, color: const Color.fromRGBO(255, 255, 255, 1))
          : Border.all(width: 2, color: const Color.fromRGBO(0, 0, 0, 1)),
        image: DecorationImage(
          alignment: const Alignment(1.3, 0),
          image: const AssetImage('assets/binance.png'),
          scale: (size.width> 520) ? 12 : 20,
          fit: BoxFit.none
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _responsiveSize(widget.orientation, size),
          Text(widget.sym, style: TextStyle(fontSize: (size.width> 520) ? 20 : 15, fontWeight: FontWeight.bold)),
          Text('${widget.per}%', style: TextStyle(fontSize: (size.width> 520) ? 12 : 10, fontWeight: FontWeight.bold)),
          Text(widget.pri, style: TextStyle(fontSize: (size.width> 520) ? 12 : 10, fontWeight: FontWeight.bold)),
        ]
      )
    );
  }

  SizedBox _responsiveSize (Orientation orientation, Size size) {
    if(orientation == Orientation.portrait) {
        if(size.width > 720) {
          return const SizedBox(height: 45);
        } else if(size.width > 520) {
          return const SizedBox(height: 20);
        } else if(size.width > 320) {
          return const SizedBox(height: 10);
        }
    } else {
        if(size.width > 1920) {
          return const SizedBox(height: 65);
        } else if(size.width > 1280) {
          return const SizedBox(height: 30);
        } else if(size.width > 1024) {
          return const SizedBox(height: 15);
        } else if(size.width > 960) {
          return const SizedBox(height: 10);
        } else if(size.width > 866) {
          return const SizedBox(height: 5);
        }
    }
    return const SizedBox(height: 0);
  }

}