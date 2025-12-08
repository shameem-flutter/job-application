import 'package:flutter/material.dart';
import 'package:job_application/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_application/constants/navigation.dart';
import 'package:job_application/constants/routenames.dart';

import 'package:job_application/screens/analytics.dart';
import 'package:job_application/screens/candidate.dart';
import 'package:job_application/screens/homescreen.dart';
import 'package:job_application/screens/message.dart';
import 'package:job_application/screens/mycompany.dart';
import 'package:job_application/screens/myjob.dart';
import 'package:job_application/screens/postajob.dart';
import 'package:job_application/screens/settings.dart';
import 'package:job_application/widgets/bottomnb.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  final PageStorageBucket _bucket = PageStorageBucket();
  late final List<Widget> _screens = [
    const CompanyHomeScreen(key: PageStorageKey('dashboard')),
    const MyJob(key: PageStorageKey('myjobs')),
    const PostJobScreen(key: PageStorageKey('postjob')),
    const MobileCombinedChatPage(key: PageStorageKey('messages')),
    const Mycompany(key: PageStorageKey('company')),
    const CandidateScreen(key: PageStorageKey('candidate')),
    const MobileDashboardScreen(key: PageStorageKey('analytics')),
    const SettingsScreen(key: PageStorageKey('settings')),
  ];

  void _onItemselected(int drawerIndex) {
    Navigator.pop(context);
    int screenIndex;
    switch (drawerIndex) {
      case 0:
        screenIndex = 0;
        break;
      case 1:
        screenIndex = 2;
        break;
      case 2:
        screenIndex = 5;
        break;
      case 3:
        screenIndex = 6;
        break;
      default:
        screenIndex = 0;
    }
    ref.read(mainNavIndexProvider.notifier).state = screenIndex;
  }

  /// ---- Bottom Nav Handler ----
  void _bottomNavigation(int index) {
    ref.read(mainNavIndexProvider.notifier).state = index;
  }

  int? _getCurrentDrawerIndex(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return 0;
      case 2:
        return 1;
      case 5:
        return 2;
      case 6:
        return 3;

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final navIndex = ref.watch(mainNavIndexProvider);
    final drawerIndex = _getCurrentDrawerIndex(navIndex);
    return WillPopScope(
      onWillPop: () async {
        final index = ref.read(mainNavIndexProvider);
        if (index != 0) {
          ref.read(mainNavIndexProvider.notifier).state = 0;
          return false;
        }
        return true;
      },

      child: Scaffold(
        /// FAB REMOVED
        floatingActionButton: null,
        floatingActionButtonLocation: null,
        bottomNavigationBar: CurvedBNB(
          currentIndex: navIndex > 4 ? -1 : navIndex,
          onTap: _bottomNavigation,
        ),

        drawerEdgeDragWidth: 60,
        backgroundColor: const Color(0xFFF8FAFC),

        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, size: 28),
            ),
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
                child: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                  size: 20,
                ),
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
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                offset: const Offset(0, 50),
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  }
                },
                elevation: 8,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text(
                      "My Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 0,
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.person),
                      title: Text("My Profile"),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.logout, color: redColor),
                      title: const Text("Logout"),
                    ),
                  ),
                ],
                child: const CircleAvatar(
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
              selectedIndex: drawerIndex,
              onDestinationSelected: _onItemselected,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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

                const NavigationDrawerDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  label: Text("Dashboard"),
                  selectedIcon: Icon(Icons.dashboard),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.add_circle_outline_outlined),
                  label: Text("Post a job"),
                  selectedIcon: Icon(Icons.add_circle),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.person_2_outlined),
                  label: Text("Candidate"),
                  selectedIcon: Icon(Icons.person),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.analytics_outlined),
                  label: Text("Analytics"),
                  selectedIcon: Icon(Icons.analytics),
                ),
              ],
            ),
          ),
        ),

        body: PageStorage(
          bucket: _bucket,
          child: IndexedStack(index: navIndex, children: _screens),
        ),
      ),
    );
  }
}
