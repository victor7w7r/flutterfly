import 'package:flutter/cupertino.dart';
import 'package:flutterfly/models/binance.dart';
import 'package:flutterfly/modules/cupertino/widgets/home_currency_card.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/providers/providers.dart' show BinanceProvider;

class CryptoTab extends StatefulWidget {
  const CryptoTab({Key? key}) : super(key: key);

  @override
  State<CryptoTab> createState() => _CryptoTabState();

}

class _CryptoTabState extends State<CryptoTab> {

  final _scrollController = ScrollController();

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
      return CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Crypto Data'),
          ),
          CupertinoSliverRefreshControl(onRefresh: _refresh),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: (6 / 3),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 10.0,
              children: [
                for (var bin in binanceProvider.bin)
                HomeCurrencyCard (
                  sym: bin.symbol,
                  per: bin.priceChangePercent,
                  pri: bin.bidPrice
                )
              ]
            )
          )
        ]
      );
    }
  }

  void _scrollListener () {
    if( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
      binanceProvider.paginateCurrencies();
      setState(() {});
    }
  }

  Future<void> _refresh() async {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
  }
}