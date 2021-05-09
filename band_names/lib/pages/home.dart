import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'U2', votes: 5),
    Band(id: '2', name: 'Queen', votes: 4),
    Band(id: '3', name: 'The Who', votes: 3),
    Band(id: '4', name: 'Ed Sheeran', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        highlightElevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name?.substring(0, 2) ?? ''),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name ?? ''),
        trailing: Text('${band.votes ?? 0}', style: TextStyle(fontSize: 20)),
        onTap: () {},
      ),
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        // TODO: delete on server
        bands.remove(band);
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Delete Band!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
                textColor: Colors.red,
                elevation: 5,
              ),
              Spacer(),
              MaterialButton(
                child: Text('Add'),
                onPressed: () => addBandToList(textController.text),
                textColor: Colors.blue,
                elevation: 5,
              ),
            ],
          );
        },
      );
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField(controller: textController),
          actions: [
            CupertinoDialogAction(
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
              isDefaultAction: true,
            ),
            CupertinoDialogAction(
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length >= 1) {
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
