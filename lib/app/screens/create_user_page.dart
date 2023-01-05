import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_api_dio/app/bloc/user/user_bloc.dart';
import 'package:simple_bloc_api_dio/app/common/shared_code.dart';
import 'package:simple_bloc_api_dio/app/repositories/user_repository.dart';
import 'package:simple_bloc_api_dio/app/screens/user_page.dart';
import 'package:simple_bloc_api_dio/app/widgets/custom_dropdown_text_field.dart';
import 'package:simple_bloc_api_dio/app/widgets/custom_text_field.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final List<String> _statusList = ['active', 'inactive'];
  final List<String> _genderList = ['male', 'female'];
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _status = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(RepositoryProvider.of<UserRepository>(context)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text('Create User')),
              body: SingleChildScrollView(
                child: Form(key: _formKey, child: _buildFormUser(context)),
              ));
        },
      ),
    );
  }

  Widget _buildFormUser(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(children: [
        CustomTextFormField(
          controller: _name,
          title: 'Name',
          hintText: 'Insert your name',
        ),
        DropDownTextField(
          hintText: 'Insert your Gender',
          title: 'Gender',
          items: _genderList,
          onChanged: (v) {
            setState(() {
              _gender.text = v;
            });
          },
        ),
        CustomTextFormField(
          controller: _email,
          title: 'Email',
          hintText: 'Insert your email',
          keyboardType: TextInputType.emailAddress,
          validator: SharedCode(context).emailValidator,
        ),
        DropDownTextField(
          hintText: 'Insert your status',
          title: 'Status',
          items: _statusList,
          onChanged: (v) {
            setState(() {
              _status.text = v;
            });
          },
        ),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                context.read<UserBloc>().add(PostUserEvent(
                    _name.text, _gender.text, _email.text, _status.text));
                Navigator.of(context).popUntil((route) => route.isFirst);
              } else {
                return null;
              }
            },
            child: Text('Create User'))
      ]),
    );
  }
}
