import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  String? _error;
  StreamSubscription<User?>? _authSub;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _authSub = FirebaseAuth.instance.authStateChanges().listen(
      _handleAuthChange,
      onError: _handleError,
    );
  }

  void _handleAuthChange(User? user) {
    _user = user;
    _updateState();
  }

  void _handleError(error) {
    _error = error.toString();
    _updateState();
  }

  void _updateState() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _authOperation(Future<UserCredential> operation) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      await operation;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _voidAuthOperation(Future<void> operation) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      await operation;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) => 
    _authOperation(FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    ));

  Future<void> login(String email, String password) => 
    _authOperation(FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
    ));

  Future<void> logout() => _voidAuthOperation(FirebaseAuth.instance.signOut());

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}