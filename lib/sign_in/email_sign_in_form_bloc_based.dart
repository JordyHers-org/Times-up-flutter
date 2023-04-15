import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/common_widgets/form_submit_button.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/services/auth.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_bloc.dart';
import 'email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  EmailSignInFormBlocBased({Key? key, required this.bloc}) : super(key: key);
  final EmailSignInBloc bloc;

  /// this is the 'create' logic [Consumer ] and [Provider]
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  ///_____________________________________________________________________________________
  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _surnameFocusNode = FocusNode();

  ///void Dispose Method
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();

    super.dispose();
  }

  /// Submit function is called when the button is pressed
  Future<void>? _submit(EmailSignInModel model) async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      await showExceptionAlertDialog(context,
          title: model.signInFailedText, exception: e);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  ///This function switches the state of the button
  void _toggleFormType(EmailSignInModel model) {
    widget.bloc.toggleFormType();
    setState(() {
      if (model.formType == EmailSignInFormType.register) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      } else {
        FocusScope.of(context).requestFocus(_nameFocusNode);
      }
    });
    _nameController.clear();
    _surnameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      model.formType == EmailSignInFormType.register
          ? TextField(
              focusNode: _nameFocusNode,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              onChanged: (name) => widget.bloc.updateName(name),
              onEditingComplete: () {
                if (model.nameValidator.isValid(model.name) == true) {
                  FocusScope.of(context).requestFocus(_surnameFocusNode);
                }
              },
              decoration: InputDecoration(
                labelText: 'Name',
                errorText:
                    model.showErrorTextName ? model.inValidNameErrorText : null,
                enabled: model.isLoading == false,
              ))
          : Opacity(opacity: 0),
      model.formType == EmailSignInFormType.register
          ? TextField(
              focusNode: _surnameFocusNode,
              controller: _surnameController,
              textInputAction: TextInputAction.next,
              onChanged: (surname) => widget.bloc.updateSurname(surname),
              onEditingComplete: () {
                if (model.surnameValidator.isValid(model.surname) == true) {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                }
              },
              decoration: InputDecoration(
                labelText: 'Surname',
                errorText: model.showErrorTextSurname
                    ? model.inValidSurnameErrorText
                    : null,
                enabled: model.isLoading == false,
              ))
          : Opacity(opacity: 0),
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: () => model.canSubmitRegister || model.canSubmitSignIn
            ? _submit(model)
            : null,
        text: model.primaryButtonText,
      ),
      SizedBox(height: 8.0),
      OutlinedButton(
        onPressed: () => !model.isLoading ? _toggleFormType(model) : null,
        child: Text(model.secondaryButtonText),
      ),
    ];
  }

  ///------------------------------ Widgets -------------------------------------------------

  Widget _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText:
              model.showErrorTextEmail ? model.inValidEmailErrorText : null,
          enabled: model.isLoading == false),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: (email) => widget.bloc.updateEmail(email),
    );
  }

  Widget _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: model.showErrorTexPassword
              ? model.inValidPasswordErrorText
              : null,
          enabled: model.isLoading == false),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _submit(model),
      onChanged: (password) => widget.bloc.updatePassword(password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<EmailSignInModel>(
          stream: widget.bloc.modelStream,
          initialData: EmailSignInModel(),
          builder: (context, snapshot) {
            final model = snapshot.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: _buildChildren(model!),
              ),
            );
          }),
    );
  }
}
