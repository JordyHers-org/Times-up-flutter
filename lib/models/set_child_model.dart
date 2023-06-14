import 'package:parental_control/sign_in/validators.dart';

class SetChildModel with EmailAndPasswordValidators {
  SetChildModel({
    this.name = '',
    this.email = '',
  });

  final String name;
  final String email;

  SetChildModel copyWith({
    required String name,
    required String email,
  }) {
    return SetChildModel(
      email: email,
      name: name,
    );
  }
// model.copyWith(email:email)
}
