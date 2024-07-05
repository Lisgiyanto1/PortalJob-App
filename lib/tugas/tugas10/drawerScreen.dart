import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Sofiyan"),
            currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/img/user.png")),
            accountEmail: Text('Sofiyan@gmail.com'),
          ),
          DrawerListData(
            iconData: Icons.group,
            title: "New Group",
            onTilePressed: () => {},
          ),
          DrawerListData(
            iconData: Icons.lock,
            title: "New Secret Group",
            onTilePressed: () => {},
          ),
          DrawerListData(
            iconData: Icons.notifications,
            title: "New Channel Chat",
            onTilePressed: () => {},
          ),
          DrawerListData(
            iconData: Icons.contacts,
            title: "contacts",
            onTilePressed: () => {},
          ),
          DrawerListData(
            iconData: Icons.bookmark_add,
            title: "Saved Message",
            onTilePressed: () => {},
          ),
          DrawerListData(
            iconData: Icons.phone,
            title: "Calls",
            onTilePressed: () => {},
          ),
        ],
      ),
    );
  }
}

class DrawerListData extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final VoidCallback? onTilePressed;

  const DrawerListData(
      {Key? key, this.iconData, this.onTilePressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title!,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
