import 'package:luthor/luthor.dart';
import 'package:supertypes/supertypes.dart';

part 'refresh_dto.supertypes.dart';

const _refreshSuperType = SuperType(
  jsonMapping: {'refreshToken': 'refresh_token'},
);

@_refreshSuperType
typedef $RefreshDto = ({String refreshToken});

SchemaValidationResult<RefreshDto> refreshDtoValidator(
  Map<String, dynamic> json,
) {
  final schema = l.schema({
    'refresh_token': l.string().required(),
  });
  return schema.validateSchema(json, fromJson: RefreshDtoFromJson);
}
