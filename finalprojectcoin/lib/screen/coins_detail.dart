import 'package:charts_flutter/flutter.dart' as charts;
import 'package:finalprojectcoin/model/coin_entity.dart';
import 'package:finalprojectcoin/repository/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinsDetail extends StatefulWidget {
  final CoinEntity coinEntity;

  const CoinsDetail({Key? key, required this.coinEntity}) : super(key: key);

  @override
  State<CoinsDetail> createState() => _CoinsDetailState();
}

class _CoinsDetailState extends State<CoinsDetail> {
  List<charts.Series<dynamic, DateTime>> historyCoin = [];
  late CoinRepository coinRepository;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDatabase();
    syncData(1);
  }

  void initDatabase() {
    coinRepository = CoinRepository();
    coinRepository.iniDatabase();
    coinRepository.isFavorite(widget.coinEntity.id ?? '').then((value) {
      isFavorite = value;
      setState(() {});
    });
  }

  void addDrRemoveFavorite() {
    if (isFavorite) {
      coinRepository.removeFavorite(widget.coinEntity);
      isFavorite = false;
    } else {
      coinRepository.addFavorite(widget.coinEntity);
      isFavorite = true;
    }
    setState(() {});
  }

  void syncData(int hours) async {
    historyCoin =
        await coinRepository.getChart(widget.coinEntity.id ?? '', hours);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.coinEntity.name.toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            IconButton(
                onPressed: addDrRemoveFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 35,
                )),
            Expanded(
              child: charts.TimeSeriesChart(
                historyCoin,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => syncData(100),
                    child: Text(
                      '100h',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    )),
                ElevatedButton(
                    onPressed: () => syncData(500),
                    child: Text(
                      '500h',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    )),
                ElevatedButton(
                    onPressed: () => syncData(1000),
                    child: Text(
                      '1000h',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    )),
                ElevatedButton(
                    onPressed: () => syncData(10000),
                    child: Text(
                      '10000h',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    )),
              ],
            )
          ],
        )),
      ),
    );
  }
}
