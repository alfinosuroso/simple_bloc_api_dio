import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/user/user_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/app_colors.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/widgets/card_user.dart';
import 'package:sizer/sizer.dart';

class UserDetailPage extends StatelessWidget {
  final int id;
  const UserDetailPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data User Detail')),
      body: BlocProvider(
        create: (context) =>
            UserBloc(RepositoryProvider.of<UserRepository>(context))
              ..add(GetUserByIdEvent(id.toString())),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              debugPrint('initial');
            }
            if (state is UserLoading) {
              debugPrint('loading');
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryRed,
                ),
              );
            }
            if (state is UserError) {
              debugPrint('error');
            }
            if (state is UserDetailLoaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  CardUser(
                    id: state.userModel.id!,
                    name: state.userModel.name!,
                    email: state.userModel.email!,
                    gender: state.userModel.gender!.toString(),
                    status: state.userModel.status!.toString(),
                    onTap: () {
                      print('asdasdasdasd');
                    },
                  ),
                ]),
              );
            }
            return const Text('No data');
          },
        ),
      ),
    );
  }
}
