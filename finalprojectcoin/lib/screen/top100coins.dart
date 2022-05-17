import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coin_repository.dart';
import 'package:finalprojectcoin/screen/coin_item_widget.dart';
import 'package:flutter/material.dart';

class Top100Coins extends StatefulWidget {
  const Top100Coins({Key? key}) : super(key: key);

  @override
  State<Top100Coins> createState() => _Top100CoinsState();
}

class _Top100CoinsState extends State<Top100Coins> {
  List<CoinEntity> listCoin = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    CoinRepository coinRepository = CoinRepository();
    List<CoinEntity> list = await coinRepository.getListCoinTop100();
    listCoin.addAll(list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListTop100Coins(),
    );
  }

  buildListTop100Coins() => ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 7),
      itemBuilder: (BuildContext context, int index) {
        CoinEntity item = listCoin[index];
        return CoinItemsWidget(item);
      },
      itemCount: listCoin.length);
}
