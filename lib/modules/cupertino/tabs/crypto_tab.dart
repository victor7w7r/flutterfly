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


  final _scrollController = ScrollController();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

   void _scrollListener () {
    if( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
      binanceProvider.paginateCurrencies();
      setState(() {});
    }
  }

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
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: _refresh,
        header:  const CupertinoSliverNavigationBar(largeTitle: Text('Crypto Data')),
        controller: _refreshController,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (6 / 3),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            physics: const AlwaysScrollableScrollPhysics(),
            mainAxisSpacing: 10.0,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
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

  Future<void> _refresh() async {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}