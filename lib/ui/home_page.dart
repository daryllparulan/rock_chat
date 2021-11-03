import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/service/auth/auth_service.dart';
import 'package:rock_chat/ui/chatroom.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/ui/dm_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget>? originalList;
  Map<int, bool>? originalDic;
  List<Widget>? listScreens;
  List<int>? listScreensIndex;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    originalList = [
      const DMPage(),
      ChatRoomPage(),
    ];
    originalDic = {0: true, 1: false, 2: false};
    listScreens = [originalList!.first];
    listScreensIndex = [0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Chat'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              })
        ],
      ),
      body: IndexedStack(
          index: listScreensIndex!.indexOf(tabIndex), children: listScreens!),
      bottomNavigationBar: _buildTabBar(),
      backgroundColor: RockColors.colorPrimary,
    );
  }

  void _selectedTab(int index) {
    if (originalDic![index] == false) {
      listScreensIndex!.add(index);
      originalDic![index] = true;
      listScreensIndex!.sort();
      listScreens = listScreensIndex!.map((index) {
        return originalList![index];
      }).toList();
    }

    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(iconData: Icons.message, text: 'Messages'),
      BottomAppBarItem(iconData: Icons.room, text: 'Rooms'),
    ];

    var items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: RockColors.colorPrimary,
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    var color = tabIndex == index ? RockColors.colorLightAccent : Colors.white;
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: 24),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  IconData iconData;
  String text;
  BottomAppBarItem({required this.iconData, required this.text});
}
