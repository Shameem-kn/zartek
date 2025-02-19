// import 'package:flutter/material.dart';

// class CustomDrawer extends StatelessWidget {
//   final String username;
//   final String uId;
//   final String imageUrl;
//   const CustomDrawer({super.key, required this.username, required this.uId, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           // Header with green gradient and rounded bottom corners
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.green, Colors.lightGreen],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                   topRight: Radius.zero),
//             ),
//             height: 200,
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   // Circular Avatar (Profile Picture)
//                   CircleAvatar(
//                     radius: 40,
//                     //   backgroundImage: NetworkImage(
//                     //       'https://via.placeholder.com/150'), // Replace with actual image URL
//                     // ),
//                     backgroundImage: AssetImage("assets/images/firebase.jpg"),
//                   ),
//                   SizedBox(height: 10),
//                   // Name Text
//                   Text(
//                     'Muhammed Naseem',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   // ID Text
//                   Text(
//                     'ID : 410',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Logout option after the header
//           ListTile(
//             leading: Icon(Icons.logout,
//                 color: const Color.fromARGB(255, 95, 94, 94)),
//             title: Text(
//               'Log out',
//               style: TextStyle(
//                   fontSize: 17,
//                   color: const Color.fromARGB(255, 95, 94, 94),
//                   fontWeight: FontWeight.w500),
//             ),
//             onTap: () {
//               // Add your logout functionality here
//               print(
//                 'Logged out',
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/google_auth/auth_bloc.dart';
import '../../../bloc/google_auth/auth_event.dart';
import '../../../bloc/google_auth/auth_state.dart';
import '../../../core/routes/route_paths.dart';

class CustomDrawer extends StatelessWidget {
  final String username;
  final String uId;
  final String imageUrl;

  const CustomDrawer({
    super.key,
    required this.username,
    required this.uId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header with green gradient and rounded bottom corners
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            height: 300,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // Circular Avatar (Profile Picture)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage("assets/images/firebase.jpg")
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  // Name Text
                  Text(
                    username.isNotEmpty ? username : 'Guest User',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // ID Text
                  Text(
                    "ID: ${uId.isNotEmpty ? uId : "N/A"}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // Logout option
          BlocListener<GoogleAuthBloc, GoogleAuthState>(
            listener: (context, state) {
              if (state is GoogleAuthSignOutSuccessState) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutePaths.authentication, (route) => false);
              } else if (state is GoogleAuthFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.grey),
              title: const Text(
                'Log out',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                context.read<GoogleAuthBloc>().add(GoogleSignOutRequested());
              },
            ),
          ),
        ],
      ),
    );
  }
}
