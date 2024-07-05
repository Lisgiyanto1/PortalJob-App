import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Chart_model.dart';
import 'package:flutter_app/tugas/tugas10/drawerScreen.dart';

class Telegram extends StatefulWidget {
  const Telegram({super.key});

  @override
  State<Telegram> createState() => _TelegramState();
}

class _TelegramState extends State<Telegram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telegram UI'),
        backgroundColor: Colors.cyan.shade600,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      drawer: DrawerScreen(),
      body: ListView.separated(
          itemBuilder: (ctx, i) {
            return ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(items[i].profileUrl!),
              ),
              title: Text(
                items[i].name!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(items[i].message!),
              trailing: Text(items[i].time!),
            );
          },
          separatorBuilder: (ctx, i) {
            return Divider();
          },
          itemCount: items.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {},
      ),
    );
  }
}
