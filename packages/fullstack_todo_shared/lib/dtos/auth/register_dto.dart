import 'package:luthor/luthor.dart';
import 'package:supertypes/supertypes.dart';

part 'register_dto.supertypes.dart';

@superTypeWithJson
typedef $RegisterDto = ({String name, String email, String password});

SchemaValidationResult<RegisterDto> registerDtoValidator(
  Map<String, dynamic> json,
) {
  final schema = l.schema({
    'name': l.string().required(),
    'email': l.string().email().required(),
    'password': l.string().min(8).required(),
  });
  return schema.validateSchema(json, fromJson: RegisterDtoFromJson);
}
