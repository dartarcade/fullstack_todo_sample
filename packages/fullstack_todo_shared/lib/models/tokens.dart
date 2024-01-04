import 'package:supertypes/supertypes.dart';

part 'tokens.supertypes.dart';

const _tokensSuperType = SuperType(
  jsonMapping: {
    'accessToken': 'access_token',
    'refreshToken': 'refresh_token',
  },
);

@_tokensSuperType
typedef $Tokens = ({String accessToken, String refreshToken});

@_tokensSuperType
typedef $AccessToken = Pick<$Tokens, ({Pick accessToken})>;
