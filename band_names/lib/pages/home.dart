import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:band_names/services/services.dart';
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
  void initState() {
    super.initState();
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);
  }

  _handleActiveBands(dynamic payload) {
    setState(() {
      this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    });
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final isConnected = (socketService.serverStatus == ServerStatus.online);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              isConnected ? Icons.check_circle : Icons.error,
              color: isConnected ? Colors.blue[300] : Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => _bandTile(bands[index]),
              physics: BouncingScrollPhysics(),
              itemCount: bands.length,
            ),
          ),
        ],
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
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name?.substring(0, 2) ?? ''),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name ?? ''),
        trailing: Text('${band.votes ?? 0}', style: TextStyle(fontSize: 20)),
        onTap: () => socketService.emit('vote-band', {'id': band.id}),
      ),
      key: UniqueKey(),
      onDismissed: (_) => socketService.emit('delete-band', {'id': band.id}),
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
        builder: (BuildContext context) => AlertDialog(
          title: Text('New band name:'),
          content: TextField(controller: textController, autofocus: true),
          actions: [
            MaterialButton(
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
              textColor: Colors.red,
              elevation: 5,
            ),
            MaterialButton(
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
              textColor: Colors.blue,
              elevation: 5,
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('New band name:'),
          content: CupertinoTextField(controller: textController, autofocus: true),
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
        ),
      );
    }
  }

  void addBandToList(String name) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    if (name.length >= 1) {
      socketService.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }

  _showGraph() {
    Map<String, double> dataMap = {};
    bands.forEach((band) {
      dataMap.putIfAbsent(band.name!, () => band.votes!.toDouble());
    });
    return Container(
      width: double.infinity,
      height: 200,
      child: PieChart(
        dataMap: dataMap,
        chartValuesOptions: ChartValuesOptions(
          showChartValuesInPercentage: true,
        ),
      ),
    );
  }
}
