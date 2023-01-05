import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/user/user_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/app_colors.dart';
import 'package:simple_bloc_api_dio/app/common/shared_code.dart';
import 'package:simple_bloc_api_dio/app/model/user.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/screens/user_page.dart';
import 'package:simple_bloc_api_dio/app/widgets/card_user.dart';
import 'package:simple_bloc_api_dio/app/widgets/custom_dropdown_text_field.dart';
import 'package:simple_bloc_api_dio/app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class DetailUserPage extends StatefulWidget {
  final int id;
  final UserModel user;
  const DetailUserPage({required this.id, required this.user, super.key});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final List<String> _statusList = ['active', 'inactive'];
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _status = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name.text = widget.user.name!;
    _gender.text = widget.user.gender!.name;
    _email.text = widget.user.email!;
    _status.text = widget.user.status!.name;
    print("ini adaaalaahh " + _status.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail User')),
      body: BlocProvider(
        create: (context) =>
            UserBloc(RepositoryProvider.of<UserRepository>(context))
              ..add(GetUserByIdEvent(widget.id.toString())),
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
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    key: _formKey,
                    child: _buildFormDetailUser(context),
                  ),
                ),
              );
            }
            return const Text('No data');
          },
        ),
      ),
    );
  }

  Widget _buildFormDetailUser(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'ID : ${widget.user.id}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      SizedBox(
        height: 2.h,
      ),
      CustomTextFormField(
        controller: _name,
        title: 'Name',
        hintText: 'Insert your name',
      ),
      CustomTextFormField(
        enabled: false,
        controller: _gender,
        title: 'Gender',
        hintText: 'Insert your gender',
      ),
      CustomTextFormField(
        controller: _email,
        title: 'Email',
        hintText: 'Insert your email',
        keyboardType: TextInputType.emailAddress,
        validator: SharedCode(context).emailValidator,
      ),
      DropDownTextField(
        title: 'Status',
        items: _statusList,
        onChanged: (v) {
          setState(() {
            _status.text = v;
          });
        },
        value: _status.text,
      ),
      ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context.read<UserBloc>().add(UpdateUserEvent(
                  widget.user.id!, _name.text, _email.text, _status.text));
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else {
              return null;
            }
          },
          child: Text('Save User')),
      SizedBox(
        height: 2.h,
      ),
      ElevatedButton(
          onPressed: () async {
            context
                .read<UserBloc>()
                .add(DeleteUserEvent(widget.user.id!.toString()));
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text('Delete User')),
    ]);
  }
}
