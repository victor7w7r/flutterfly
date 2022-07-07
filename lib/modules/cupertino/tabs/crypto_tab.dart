import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart' show Provider;
import 'package:flutterfly/providers/providers.dart' show BinanceProvider;

class CryptoTab extends StatefulWidget {
  const CryptoTab({Key? key}) : super(key: key);

  @override
  State<CryptoTab> createState() => _CryptoTabState();
}

class _CryptoTabState extends State<CryptoTab> {

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
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
        ),
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Cryptocurrency data')
          ),
          CupertinoSliverRefreshControl(onRefresh: _refresh),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => items[index],
              childCount: items.length,
            ),
          ),
        ],
      );
    }
  }

  Future<void> _refresh() async {
    final binanceProvider = Provider.of<BinanceProvider>(context, listen: false);
    await binanceProvider.getCurrencies();
    setState(() {});
  }


}