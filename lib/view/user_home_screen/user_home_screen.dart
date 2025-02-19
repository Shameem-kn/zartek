// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zartek/repository/user_pref/user_pref_repo.dart';
// import 'package:zartek/view/user_home_screen/tab_view.dart';
// import 'package:zartek/view/user_home_screen/widgets/custom_drawer.dart';
// import '../../bloc/cart/cart_bloc.dart';
// import '../../bloc/cart/cart_state.dart';
// import '../../bloc/menu/menu_bloc.dart';
// import '../../bloc/menu/menu_event.dart';
// import '../../bloc/menu/menu_state.dart';

// import '../../core/routes/route_paths.dart';

// class UserHomeScreen extends StatefulWidget {
//   const UserHomeScreen({super.key});

//   @override
//   State<UserHomeScreen> createState() => _UserHomeScreenState();
// }

// class _UserHomeScreenState extends State<UserHomeScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   List<String> tabNames = [];

//   @override
//   void initState() {
//     super.initState();

//     context.read<MenuBloc>().add(FetchMenuEvent());
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<MenuBloc, MenuState>(
//         builder: (context, state) {
//           if (state is MenuLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is MenuLoaded) {
//             // Initialize tab names dynamically
//             tabNames =
//                 state.menu.categories.map((category) => category.name).toList();

//             // Initialize the TabController only if it's null or needs updating
//             _tabController ??=
//                 TabController(length: tabNames.length, vsync: this);

//             return Scaffold(
//               appBar: AppBar(
//                 leading: Builder(
//                   builder: (context) {
//                     return IconButton(
//                       onPressed: () {
//                         Scaffold.of(context).openDrawer();
//                       },
//                       icon: const Icon(Icons.menu, color: Colors.grey),
//                     );
//                   },
//                 ),
//                 actions: [
//                   BlocBuilder<CartBloc, CartState>(
//                     builder: (context, state) {
//                       return IconButton(
//                         padding: const EdgeInsets.only(right: 10),
//                         onPressed: () {
//                           Navigator.pushNamed(context, RoutePaths.cart);
//                         },
//                         icon: state.cartCount > 0
//                             ? Badge(
//                                 isLabelVisible: true,
//                                 backgroundColor: Colors.red,
//                                 label: Text("${state.cartCount}"),
//                                 offset: const Offset(9, -3),
//                                 textColor: Colors.white,
//                                 child: const Icon(Icons.shopping_cart,
//                                     color: Colors.grey, size: 27),
//                               )
//                             : const Icon(Icons.shopping_cart,
//                                 color: Colors.grey, size: 27),
//                       );
//                     },
//                   ),
//                 ],
//                 bottom: TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   indicatorColor: Colors.red,
//                   labelColor: Colors.red,
//                   unselectedLabelColor: Colors.black,
//                   tabs: tabNames.map((tab) => Tab(text: tab)).toList(),
//                 ),
//               ),
//               drawer: CustomDrawer(),
//               body: TabBarView(
//                 controller: _tabController,
//                 children: List.generate(
//                   tabNames.length,
//                   (index) => TabView(
//                       category: state.menu
//                           .categories[index]), // Pass category name if needed
//                 ),
//               ),
//             );
//           } else if (state is MenuError) {
//             return Center(child: Text(state.message));
//           }
//           return const Center(child: Text("Something went wrong"));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek/view/user_home_screen/tab_view.dart';
import 'package:zartek/view/user_home_screen/widgets/custom_drawer.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_state.dart';
import '../../bloc/menu/menu_bloc.dart';
import '../../bloc/menu/menu_event.dart';
import '../../bloc/menu/menu_state.dart';
import '../../core/routes/route_paths.dart';
import '../../repository/user_pref/user_pref_repo_impl.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> tabNames = [];
  late UserPrefRepoImpl userPrefRepo;

  // Provide default values to avoid uninitialized errors
  String username = 'Guest';
  String uId = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    context.read<MenuBloc>().add(FetchMenuEvent());
  }

  Future<void> _initializeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userPrefRepo = UserPrefRepoImpl(prefs);

    final userData = await userPrefRepo.getUserData();
    if (mounted) {
      setState(() {
        username = userData['username'] ?? 'Guest';
        uId = userData['uid'] ?? '';
        imageUrl = userData['imageUrl'] ?? "";
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MenuLoaded) {
            tabNames =
                state.menu.categories.map((category) => category.name).toList();

            _tabController ??=
                TabController(length: tabNames.length, vsync: this);

            return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu, color: Colors.grey),
                    );
                  },
                ),
                actions: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return IconButton(
                        padding: const EdgeInsets.only(right: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, RoutePaths.cart);
                        },
                        icon: state.cartCount > 0
                            ? Badge(
                                isLabelVisible: true,
                                backgroundColor: Colors.red,
                                label: Text("${state.cartCount}"),
                                offset: const Offset(9, -3),
                                textColor: Colors.white,
                                child: const Icon(Icons.shopping_cart,
                                    color: Colors.grey, size: 27),
                              )
                            : const Icon(Icons.shopping_cart,
                                color: Colors.grey, size: 27),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.red,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  tabs: tabNames.map((tab) => Tab(text: tab)).toList(),
                ),
              ),
              drawer: CustomDrawer(
                username: username,
                uId: uId,
                imageUrl: imageUrl,
              ),
              body: TabBarView(
                controller: _tabController,
                children: List.generate(
                  tabNames.length,
                  (index) => TabView(category: state.menu.categories[index]),
                ),
              ),
            );
          } else if (state is MenuError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
