import 'package:luthor/luthor.dart';
import 'package:supertypes/supertypes.dart';

part 'login_dto.supertypes.dart';

@superTypeWithJson
typedef $LoginDto = ({
  String email,
  String password,
});

SchemaValidationResult<LoginDto> loginDtoValidator(
  Map<String, dynamic> json,
) {
  final schema = l.schema({
    'email': l.string().email().required(),
    'password': l.string().min(8).required(),
  });
  return schema.validateSchema(json, fromJson: LoginDtoFromJson);
}
