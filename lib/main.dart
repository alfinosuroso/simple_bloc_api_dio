import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/app_theme_data.dart';
import 'package:simple_bloc_api_dio/app/repositories/search_repository.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/screens/user_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, DeviceType) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => UserRepository(),
            ),
            RepositoryProvider(
              create: (context) => SearchRepository(),
            ),
          ],
          child: MaterialApp(
            title: 'Simple Bloc Api Dio',
            debugShowCheckedModeBanner: false,
            theme: AppThemeData.getTheme(context),
            home: UserPage(),
          ),
        );
      },
    );
  }
}
