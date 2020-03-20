import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '                            Cristina'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Coin>> getCoins() async{
    List<Coin> _jsonListMap;

    String api = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=00280d57-72e8-4d65-b9dd-d5a4410dec58";

    final response = await http.get(api);

    if(response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      _jsonListMap = jsonList.map((dynamic i) => Coin.fromJson(i)).toList();
      //fromJson(i)).toList();
      return _jsonListMap;
    }
  }

  //    print(coins.length);
  //    return coins;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder <List<Coin>> (
            future: getCoins(),
            builder: (BuildContext context, dynamic snapshot){

              if(snapshot.hasData){
                print(snapshot.data);
                return Container(
                    child: Center(
                        child: Text('tengo datos')
                    )
                );
              }

              return Container(
                child: Center(
                  child: Text('No hay datos'),
                ),
              );
            }
        ),
      ),
    );
  }
}

class Coin {
  final int id;
  final String name;
  final String symbol;
  final double price;
  final double percent_change_1h;

  Coin({this.id, this.name, this.symbol, this.price, this.percent_change_1h});

  Coin.frontJson(Map json):id = json['id'],
        name = json['name'],
        symbol = json['symbol'],
        price = json['price'],
        percent_change_1h = json['percent_change_1h'];

  factory Coin.fromJson(Map<String, dynamic> parsedJson) {
    return Coin(
      name: parsedJson['name'],
      symbol: parsedJson['symbol'],
      price: parsedJson['price'],
      percent_change_1h: parsedJson['percen_change_1h'],
    );
  }
}