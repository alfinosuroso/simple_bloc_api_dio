import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_bloc_api_dio/app/common/app_colors.dart';

class CardUser extends StatelessWidget {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;
  final Function onTap;
  const CardUser({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'ID : $id',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      gender,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      status,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
