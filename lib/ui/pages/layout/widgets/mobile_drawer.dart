import 'package:flutter/material.dart';
import 'sidebar_navigation.dart';

Widget mobileDrawer(BuildContext context) {
  return  
  Drawer(
        child: 
        SidebarNavigation(),
        // ListView(
        //   padding: EdgeInsets.zero,
        //   children: const [
        //     DrawerHeader(
        //       decoration: BoxDecoration(color: Colors.blue),
        //       child: Text('Menu'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.home),
        //       title: Text('Trang chủ'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.info),
        //       title: Text('Giới thiệu'),
        //     ),
        //   ],
        // ),
      );
}