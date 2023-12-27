import 'package:luthor/luthor.dart';
import 'package:supertypes/supertypes.dart';

part 'todo.supertypes.dart';

const _superTypesTodo = SuperType(
  jsonMapping: {
    'userId': 'user_id',
    'isDone': 'is_done',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

@_superTypesTodo
typedef $Todo = ({
  int id,
  int userId,
  String title,
  String description,
  bool isDone,
  DateTime createdAt,
  DateTime updatedAt,
});

@_superTypesTodo
typedef $CreateTodo = Pick<
    $Todo,
    ({
      Pick title,
      Pick description,
    })>;

SchemaValidationResult<CreateTodo> createTodoValidator(
    Map<String, dynamic> json) {
  final schema = l.schema({
    'title': l.string().required(),
    'description': l.string().required(),
  });
  return schema.validateSchema(json, fromJson: CreateTodoFromJson);
}
