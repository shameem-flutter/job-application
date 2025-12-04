import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/constants/routenames.dart';
import 'package:job_application/widgets/bottomnb.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int drawerIndex;
  final int bottomNavIndex;
  const MainLayout({
    super.key,
    required this.child,
    required this.drawerIndex,
    required this.bottomNavIndex,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int get drawerItem => widget.drawerIndex;
  int get bottomItem => widget.bottomNavIndex;

  void _onItemselected(int index) {
    if (index == drawerItem) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    late String route;
    switch (index) {
      case 0:
        route = RouteNames.dashboard;
        break;
      case 1:
        route = RouteNames.postJob;
        break;
      case 2:
        route = RouteNames.candidate;
        break;
      case 3:
        route = RouteNames.analytics;
        break;
      default:
        return;
    }
    final current = ModalRoute.of(context)?.settings.name;
    if (current == route) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.dashboard,
      (route) => false,
    );
    if (route != RouteNames.dashboard) {
      Navigator.pushNamed(context, route);
    }
  }

  void _bottomNavigation(int index) {
    String route;

    switch (index) {
      case 0:
        route = RouteNames.dashboard;
        break;
      case 1:
        route = "/my-jobs";
        break;
      case 2:
        route = "/messages";
        break;
      case 3:
        route = "/my-company";
        break;
      default:
        return;
    }
    if (ModalRoute.of(context)?.settings.name == route) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.dashboard,
      (route) => false,
    );
    if (route != RouteNames.dashboard) {
      Navigator.pushNamed(context, route);
    }
  }

  int _bottomNavIndex() {
    if (bottomItem == -1) {
      return -1;
    }

    return bottomItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.dashboard,
            (route) => false,
          );

          Navigator.pushNamed(context, RouteNames.postJob);
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedBNB(
        currentIndex: _bottomNavIndex(),
        onTap: _bottomNavigation,
      ),
      drawerEdgeDragWidth: 60,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, size: 28),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.dashboard, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'upmatch',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: Offset(0, 50),
              onSelected: (value) {},
              elevation: 8,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    "My Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.person),
                    title: Text("My Profile"),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.settings),
                    title: Text("Setttings"),
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.logout, color: redColor),
                    title: Text("LogOut"),
                  ),
                ),
              ],
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('a', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: NavigationDrawer(
            backgroundColor: primaryColor,
            selectedIndex: drawerItem,
            onDestinationSelected: _onItemselected,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UpMatch",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("HR Dashboard", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),

              NavigationDrawerDestination(
                icon: Icon(Icons.dashboard_outlined),
                label: Text("Dashboard"),
                selectedIcon: Icon(Icons.dashboard),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.add_circle_outline_outlined),
                label: Text("Post a job"),
                selectedIcon: Icon(Icons.add_circle),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.person_2_outlined),
                label: Text("Candidate"),
                selectedIcon: Icon(Icons.person),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.analytics_outlined),
                label: Text("Analytics"),
                selectedIcon: Icon(Icons.analytics),
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
    );
  }
}
