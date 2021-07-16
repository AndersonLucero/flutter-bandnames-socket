import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Raze', votes: 10),
    Band(id: '2', name: 'Omen', votes: 9),
    Band(id: '3', name: 'Jett', votes: 5),
    Band(id: '4', name: 'Yoru', votes: 6),
    Band(id: '5', name: 'Astra', votes: 14),
    Band(id: '6', name: 'Brimstone', votes: 7),
    Band(id: '7', name: 'Sova', votes: 13),
    Band(id: '8', name: 'Fenix', votes: 17),
    Band(id: '9', name: 'Reina', votes: 19),
    Band(id: '10', name: 'Kayo', votes: 11),
    Band(id: '11', name: 'Sky', votes: 2),
    Band(id: '12', name: 'Brich', votes: 67),
    Band(id: '13', name: 'kill Joy', votes: 99),
    Band(id: '14', name: 'Maick', votes: 100),
    Band(id: '15', name: 'Emilia', votes: 90),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.red[300]),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandtile(bands[i])),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), elevation: 1, onPressed: addNewBand),
    );
  }

  Widget _bandtile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('*****Direction: $direction');
        print('*****Direction: ${band.id}');
        //TODO: llamar el borrado en el server
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Delete Band', style: TextStyle(color: Colors.white)),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.red[400],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 15)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      //android
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text('New band name'),
                content: TextField(
                  controller: textController,
                ),
                actions: <Widget>[
                  MaterialButton(
                      child: Text('Add'),
                      elevation: 5,
                      textColor: Colors.red[400],
                      onPressed: () => addBandToList(textController.text))
                ]);
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('add'),
                  onPressed: () => addBandToList(textController.text)),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //podemos agregar
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
