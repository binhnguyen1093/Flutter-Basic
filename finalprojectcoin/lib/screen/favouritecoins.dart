import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coin_repository.dart';
import 'package:finalprojectcoin/screen/coin_item_widget.dart';
import 'package:flutter/material.dart';

class FavouriteCoins extends StatefulWidget {
  const FavouriteCoins({Key? key}) : super(key: key);

  @override
  State<FavouriteCoins> createState() => _FavouriteCoinsState();
}

class _FavouriteCoinsState extends State<FavouriteCoins> {
  List<CoinEntity> listFavoriteCoins = [];

  @override
  void initState() {
    super.initState();
    final coinRespository = CoinRepository();

    coinRespository.getListFavorite().then((value) {
      listFavoriteCoins.clear();
      listFavoriteCoins.addAll(value ?? List.empty());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildListFavorite(),
      ),
    );
  }

  buildListFavorite() => ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 7),
      itemBuilder: (BuildContext context, int index) {
        CoinEntity item = listFavoriteCoins[index];
        return CoinItemsWidget(item);
      },
      itemCount: listFavoriteCoins.length);
}
