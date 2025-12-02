import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:job_application/widgets/bottomnb.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  const MainLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int get selectedItem => widget.selectedIndex;

  void _onItemselected(int index) {
    if (index == selectedItem) {
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name == "/dashboard") return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/dashboard",
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/post-job",
          ModalRoute.withName("/dashboard"),
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/my-jobs",
          ModalRoute.withName("/dashboard"),
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/my-company",
          ModalRoute.withName("/dashboard"),
        );
        break;
      case 4:
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/messages",
          ModalRoute.withName("/dashboard"),
        );
        break;
      case 5:
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/analytics",
          ModalRoute.withName("/dashboard"),
        );
        break;
    }
  }

  void _bottomNavigation(int index) {
    int newSelectedItem;
    String route;

    switch (index) {
      case 0:
        newSelectedItem = 0;
        route = "/dashboard";
        break;
      case 1:
        newSelectedItem = 2;
        route = "/my-jobs";
        break;
      case 2:
        newSelectedItem = 4;
        route = "/messages";
        break;
      case 3:
        newSelectedItem = 3;
        route = "/my-company";
        break;
      default:
        return;
    }
    if (newSelectedItem == selectedItem) return;

    if (route == "/dashboard") {
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        ModalRoute.withName("/dashboard"),
      );
    }
  }

  int _bottomNavIndex() {
    switch (selectedItem) {
      case 0:
        return 0;
      case 2:
        return 1;
      case 4:
        return 2;
      case 3:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/post-job",
            ModalRoute.withName("/dashboard"),
          );
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
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text('a', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: NavigationDrawer(
            backgroundColor: primaryColor,
            selectedIndex: selectedItem,
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
                icon: Icon(Icons.work_outline),
                label: Text("My job"),
                selectedIcon: Icon(Icons.work),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.business_outlined),
                label: Text("My company"),
                selectedIcon: Icon(Icons.business_rounded),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.message_outlined),
                label: Text("Messages"),
                selectedIcon: Icon(Icons.message),
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
