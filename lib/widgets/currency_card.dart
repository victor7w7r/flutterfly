import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterfly/providers/providers.dart';

class CurrencyCard extends StatefulWidget {
  const CurrencyCard({
    Key? key,
    required this.sym,
    required this.per,
    required this.pri
  }): super(key: key);

  final String sym;
  final String per;
  final String pri;

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(widget.sym, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text('${widget.per}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(widget.pri, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
        ]
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: themeProvider.darkState
          ? Border.all(width: 2, color: Colors.white)
          : Border.all(width: 2, color: Colors.black),
        image: const DecorationImage(
          alignment: Alignment(1.3, -5),  
          image: AssetImage('assets/binance.png'),
          scale: 12,
          fit: BoxFit.none
        )
      )
    );
  }
}