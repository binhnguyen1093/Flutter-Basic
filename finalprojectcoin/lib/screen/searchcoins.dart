import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coin_repository.dart';
import 'package:finalprojectcoin/screen/coin_item_widget.dart';
import 'package:flutter/material.dart';

class SearchCoins extends StatefulWidget {
  const SearchCoins({Key? key}) : super(key: key);

  @override
  State<SearchCoins> createState() => _SearchCoinsState();
}

class _SearchCoinsState extends State<SearchCoins> {
  List<CoinEntity> listSearchCoins = [];
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    listSearchCoins.addAll(CoinRepository.listCoin);
    setState(() {});
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty) {
        listSearchCoins.clear();
        final list = CoinRepository.listCoin.where((element) =>
            element.name
                ?.toLowerCase()
                .contains(textEditingController.text.toLowerCase()) ==
            true);
        listSearchCoins.addAll(list);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildEditTextSearch(),
          const SizedBox(height: 20),
          buildListSearchCoins()
        ],
      ),
    );
  }

  buildEditTextSearch() => Padding(
        padding: const EdgeInsets.all(17.0),
        child: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a coin name',
          ),
        ),
      );
  buildListSearchCoins() => Expanded(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 7),
            itemBuilder: (BuildContext context, int index) {
              CoinEntity item = listSearchCoins[index];
              return CoinItemsWidget(item);
            },
            itemCount: listSearchCoins.length),
      );
}
