import 'package:flutter/material.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/material/widgets/widgets.dart' show HomeCurrencyCard;
import 'package:flutterfly/providers/providers.dart' show BinanceProvider;

class HomeCurrencyList extends StatefulWidget {
  const HomeCurrencyList({Key? key, required this.orientation}) : super(key: key);

  final Orientation orientation;

  @override
  State<HomeCurrencyList> createState() => _HomeCurrencyListState();

}

class _HomeCurrencyListState extends State<HomeCurrencyList> {

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
          SizedBox(height: 120), CircularProgressIndicator()
        ]
      );
    } else {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: _refresh,
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
                orientation: widget.orientation,
              )
            ]
          )
        )
      );
    }
  }

  Future<void> _refresh() async {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
  }

  void _scrollListener () {
    if( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
      binanceProvider.paginateCurrencies();
      setState(() {});
    }
  }
}