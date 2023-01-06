import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/search/search_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/user/user_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/app_colors.dart';
import 'package:simple_bloc_api_dio/app/repositories/search_repository.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/screens/detail_user_page.dart';
import 'package:simple_bloc_api_dio/app/screens/create_user_page.dart';
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
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryRed,
                ),
              );
            }
            if (state is UserError) {
              debugPrint('error');
            }
            if (state is UserLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<UserBloc>(context).add(GetAllUserEvent());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(children: [
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 70.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.bluishBlack)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Search...',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(
                                      color: AppColors.darkGrey,
                                    )),
                            const Icon(
                              Icons.search,
                              color: AppColors.darkGrey,
                            ),
                          ],
                        )),
                      ),
                      onTap: () {
                        showSearch(context: context, delegate: UserSearch());
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
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
                              gender: state.userModel[index].gender!.name,
                              status: state.userModel[index].status!.name,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailUserPage(
                                      id: state.userModel[index].id!,
                                      user: state.userModel[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ]),
                ),
              );
            }
            return const Text('No data');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            size: 12.w,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateUserPage(),
                ));
          }),
    );
  }
}

class UserSearch extends SearchDelegate<List> {
  String queryString;
  UserSearch({this.queryString = ''});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, [null]);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    debugPrint('asdasd');
    // searchBloc.add(SearchUserEvent(queryString));

    return BlocProvider(
      create: (context) =>
          SearchBloc(RepositoryProvider.of<SearchRepository>(context))
            ..add(SearchUserEvent(queryString)),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            debugPrint('initial');
          }
          if (state is SearchLoading) {
            debugPrint('loading');
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryRed,
              ),
            );
          }
          if (state is SearchError) {
            debugPrint('error');
          }
          if (state is SearchLoaded) {
            if (state.userModel.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }
            if (queryString.isEmpty) {
              return const Center(
                child: Text('Search User Name'),
              );
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
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
                            gender: state.userModel[index].gender!.name,
                            status: state.userModel[index].status!.name,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailUserPage(
                                    id: state.userModel[index].id!,
                                    user: state.userModel[index],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Search User Name'),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
