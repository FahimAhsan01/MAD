class Todo {
  final String id, title, description;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Todo.fromFirebase(Map<String, dynamic> data, String id) => Todo(
    id: id,
    title: data['title']?.toString() ?? '',
    description: data['description']?.toString() ?? '',
  );

  Map<String, dynamic> toMap() => {'title': title, 'description': description};

  Todo copyWith({String? id, String? title, String? description}) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
  );

  @override
  String toString() => 'Todo(id: $id, title: $title, description: $description)';
}