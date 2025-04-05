import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';
import 'dart:async';

class TodoProvider with ChangeNotifier {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  late DatabaseReference _userTodosRef;
  List<Todo> _todos = [];
  String? _error;
  bool _isLoading = true;
  StreamSubscription? _sub;

  List<Todo> get todos => _todos;
  String? get error => _error;
  bool get isLoading => _isLoading;

  TodoProvider() {
    _init();
  }

  void _init() {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) throw Exception('Not authenticated');

      _userTodosRef = _db.child('todos/${_sanitize(uid)}');
      _sub = _userTodosRef.onValue.listen(_handleData, onError: _handleError);
    } catch (e) {
      _updateState(error: e.toString());
    }
  }

  void _handleData(DatabaseEvent event) {
    final data = event.snapshot.value as Map?;
    _todos = data?.entries.map((e) => Todo(
      id: e.key.toString(),
      title: e.value['title']?.toString() ?? '',
      description: e.value['description']?.toString() ?? '',
    )).toList() ?? [];
    _updateState();
  }

  void _handleError(error) => _updateState(error: error.toString());

  String _sanitize(String input) => input.replaceAll(RegExp(r'[\.\$#\[\]/]'), '_');

  void _updateState({String? error}) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _dbOperation(Future<void> operation) async {
    try {
      await operation;
      _updateState();
    } catch (e) {
      _updateState(error: e.toString());
      rethrow;
    }
  }

  Future<void> addTodo(Todo todo) => _dbOperation(
    _userTodosRef.child(_sanitize(todo.id)).set({
      'title': todo.title,
      'description': todo.description,
      'createdAt': ServerValue.timestamp,
    })
  );

  Future<void> updateTodo(Todo todo) => _dbOperation(
    _userTodosRef.child(todo.id).update({
      'title': todo.title,
      'description': todo.description,
      'updatedAt': ServerValue.timestamp,
    })
  );

  Future<void> deleteTodo(String id) => _dbOperation(
    _userTodosRef.child(id).remove()
  );

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}