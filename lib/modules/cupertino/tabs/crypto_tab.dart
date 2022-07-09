import 'package:flutter/cupertino.dart';
import 'package:flutterfly/modules/cupertino/widgets/home_currency_card.dart';

import 'package:provider/provider.dart' show Provider;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutterfly/providers/providers.dart' show BinanceProvider;

class CryptoTab extends StatefulWidget {
  const CryptoTab({Key? key}) : super(key: key);

  @override
  State<CryptoTab> createState() => _CryptoTabState();
}

class _CryptoTabState extends State<CryptoTab> {

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {

    final binanceProvider = Provider.of<BinanceProvider>(context);

    if(binanceProvider.loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 120), CupertinoActivityIndicator()
        ]
      );
    } else {
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _refresh,
        onLoading: _loading,
        header: const CupertinoSliverNavigationBar(largeTitle: Text('Crypto Data')),
        controller: _refreshController,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (6 / 3),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          mainAxisSpacing: 10.0,
          scrollDirection: Axis.vertical,
          children: [
            for (var bin in binanceProvider.bin)
            HomeCurrencyCard (
              sym: bin.symbol,
              per: bin.priceChangePercent,
              pri: bin.bidPrice,
            )
          ]
        )
      );
    }
  }

  void _loading () {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    binanceProvider.paginateCurrencies();
    setState(() {});
    _refreshController.loadComplete();
  }

  Future<void> _refresh() async {
    print('a');
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}