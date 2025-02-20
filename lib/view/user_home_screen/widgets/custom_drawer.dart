import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartek/core/color/color.dart';
import 'package:zartek/utils/screen_size_finder.dart';

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
            height: screenHeight * .35,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : const AssetImage("assets/images/firebase.jpg")
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username.isNotEmpty ? username : 'Guest User',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
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
              leading: const Icon(Icons.logout, color: AppColors.grey),
              title: const Text(
                'Log out',
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.grey,
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
