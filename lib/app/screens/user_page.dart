import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/user/user_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/app_colors.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/screens/user_detail_page.dart';
import 'package:simple_bloc_api_dio/app/widgets/card_user.dart';
import 'package:sizer/sizer.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data User')),
      body: BlocProvider(
        create: (context) =>
            UserBloc(RepositoryProvider.of<UserRepository>(context))
              ..add(GetAllUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              debugPrint('initial');
            }
            if (state is UserLoading) {
              debugPrint('loading');
              const CircularProgressIndicator(
                color: AppColors.primaryRed,
              );
            }
            if (state is UserError) {
              debugPrint('error');
            }
            if (state is UserLoaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  TextFormField(),
                  Expanded(
                    child: ListView.separated(
                        itemCount: state.userModel.length,
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            height: 1.5.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return CardUser(
                            id: state.userModel[index].id!,
                            name: state.userModel[index].name!,
                            email: state.userModel[index].email!,
                            gender: state.userModel[index].gender!.toString(),
                            status: state.userModel[index].status!.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailPage(
                                      id: state.userModel[index].id!),
                                ),
                              );
                            },
                          );
                        }),
                  )
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
