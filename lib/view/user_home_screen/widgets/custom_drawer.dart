import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header with green gradient and rounded bottom corners
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.zero),
            ),
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Circular Avatar (Profile Picture)
                  CircleAvatar(
                    radius: 40,
                    //   backgroundImage: NetworkImage(
                    //       'https://via.placeholder.com/150'), // Replace with actual image URL
                    // ),
                    backgroundImage: AssetImage("assets/images/firebase.jpg"),
                  ),
                  SizedBox(height: 10),
                  // Name Text
                  Text(
                    'Muhammed Naseem',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  // ID Text
                  Text(
                    'ID : 410',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Logout option after the header
          ListTile(
            leading: Icon(Icons.logout,
                color: const Color.fromARGB(255, 95, 94, 94)),
            title: Text(
              'Log out',
              style: TextStyle(
                  fontSize: 17,
                  color: const Color.fromARGB(255, 95, 94, 94),
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              // Add your logout functionality here
              print(
                'Logged out',
              );
            },
          ),
        ],
      ),
    );
  }
}
