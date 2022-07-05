import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;

import 'package:flutterfly/modules/material/widgets/widgets.dart' show HomeCurrencyCard;
import 'package:flutterfly/providers/providers.dart' show BinanceProvider;

import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {

  final binanceProvider = Provider.of<BinanceProvider>(context);

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

    if(binanceProvider.loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 120), CupertinoActivityIndicator()
        ]
      );
    } else {
     /* return Expanded(
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
        */
       return SmartRefresher(
           enablePullDown: true,
            controller: _refreshController,
            child: ListView.builder(
          itemBuilder: (c, i) => Container(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      );
    }
  }

  Future<void> _refresh() async {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _scrollListener () {
    if( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
      binanceProvider.paginateCurrencies();
      setState(() {});
    }
  }
}