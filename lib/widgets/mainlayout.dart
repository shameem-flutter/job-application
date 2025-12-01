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
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedIndex;
  }

  void _onItemselected(int index) {
    if (index == selectedItem) return;
    setState(() {
      selectedItem = index;
    });
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/dashboard");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/post-job");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/my-jobs");
        break;
      case 3:
        Navigator.pushReplacementNamed(context, "/my-company");
        break;
      case 4:
        Navigator.pushReplacementNamed(context, "/messages");
        break;
      case 5:
        Navigator.pushReplacementNamed(context, "/analytics");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedBNB(
        currentIndex: selectedItem,
        onTap: _onItemselected,
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
                selectedIcon: Icon(Icons.business),
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
