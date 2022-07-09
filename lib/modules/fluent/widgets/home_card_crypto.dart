import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart'
;
import 'package:flutterfly/models/binance.dart';

class HomeCardCrypto extends StatelessWidget {

  const HomeCardCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<FluentProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Card(
      backgroundColor: themeProvider.cardColor,
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.fromLTRB(
        100, size.width > 960 ? 75 : 5,
        100, size.width > 960 ? 75 : 5
      ),
      child: Column(
        children: [
          const SizedBox(height: 45),
          _storeState(context),
          const SizedBox(height: 45),
          ..._cryptoData(context)
        ]
      )
    );
  }

  List<Widget> _cryptoData(BuildContext context) {
    final binanceProvider = Provider.of<BinanceProvider>(context);
    final themeProvider = Provider.of<FluentProvider>(context, listen: true);
    if(binanceProvider.loading) {
      return const [ProgressRing(value: 35)];
    } else {
      Binance bitcoin = binanceProvider.bin.firstWhere(
        (element) => element.symbol == 'BTCUSDT'
      );
      return [
        Text('Symbol: ${bitcoin.symbol}',
          style: TextStyle(color: themeProvider.invertedColor, fontSize: 20)
        ),
        Text('Symbol: ${bitcoin.askPrice}',
          style: TextStyle(color: themeProvider.invertedColor, fontSize: 20)
        ),
        const SizedBox(height: 45)
      ];
    }
  }

  Text _storeState(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    final themeProvider = Provider.of<FluentProvider>(context, listen: true);
    if (dataProvider.data.isEmpty) {
      return Text(
        'Store State: Not Yet',
        style: TextStyle(color: themeProvider.invertedColor, fontSize: 20)
      );
    } else {
      return Text(
        'Store state: Yes, you write. ${dataProvider.data}',
        style: TextStyle(color: themeProvider.invertedColor, fontSize: 20)
      );
    }
  }
}