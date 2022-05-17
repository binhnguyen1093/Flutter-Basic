import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/screen/coins_detail.dart';
import 'package:flutter/material.dart';

class CoinItemsWidget extends StatelessWidget {
  final CoinEntity item;
  const CoinItemsWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CoinsDetail(
                      coinEntity: item,
                    )));
      },
      child: Container(
        height: 115,
        color: Colors.black12.withOpacity(0.09),
        padding: EdgeInsets.fromLTRB(20, 30, 7, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  item.marketCapRank.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 10),
                Image.network(
                  item.image ?? '',
                  width: 70,
                  height: 70,
                ),
                Text(
                  item.name.toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.currentPrice.toString() + ' USD',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.priceChangePercentage24h.toString() + " %",
                  style: TextStyle(
                      color: (item.priceChangePercentage24h ?? 0) < 0
                          ? Colors.red
                          : Colors.blueAccent,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
