import 'package:flutter/material.dart';
import 'package:zartek/view/user_home_screen/tab_view.dart';
import 'package:zartek/view/user_home_screen/widgets/custom_drawer.dart';
import '../../core/routes/route_paths.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabNames = [
    'Starters',
    'Breakfast',
    'Lunch',
    'Supper',
    'Dessert',
    'Beverages',
    'Brunch',
    'Italian',
    'Chinese',
    'Continental'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabNames.length, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Ensures only completed tab changes trigger setState
        setState(() {}); // Forces rebuild so tab text color updates
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Open the drawer using the correct context
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            );
          },
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 10),
              onPressed: () {
                // Navigate to UserCheckoutScreen on checkout
                Navigator.pushNamed(context, RoutePaths.cart);
              },
              icon: Badge(
                isLabelVisible: true,
                backgroundColor: Colors.red,
                label: const Text("2"),
                offset: const Offset(9, -3),
                textColor: Colors.white,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                  size: 27,
                ),
              )),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.red,
          tabs: List.generate(tabNames.length, (index) {
            return Tab(
              child: Text(
                tabNames[index],
                style: TextStyle(
                  color: _tabController.index == index
                      ? Colors.red // Active tab color
                      : Colors.black, // Inactive tab color
                ),
              ),
            );
          }),
        ),
      ),
      drawer: CustomDrawer(), // Add the CustomDrawer here
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          tabNames.length,
          (index) => const TabView(),
        ),
      ),
    );
  }
}
