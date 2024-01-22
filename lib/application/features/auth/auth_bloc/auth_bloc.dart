import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterly_bloc_auth/application/features/auth/models/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async {
      User? user;
      try {
        await Future.delayed(Duration(seconds: 2), () {
          user = _auth.currentUser;
        });

        if (user != null) {
          emit(Authenticated(user!));
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        emit(AuthenticatedError(error: e.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: event.user!.email.toString(),
            password: event.user!.password.toString());

        final user = userCredential.user;

        if (user != null) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': user.email,
            'name': event.user!.name,
            'phone': event.user!.phone,
            'createdAt': DateTime.now()
          });
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        AuthenticatedError(error: e.toString());
      }
    });

    on<LoginEvent>((event, emit) async{

      emit(AuthLoading());

      try {

        final userCredential = await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);

        final user = userCredential.user;

        if(user!=null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } catch(e) {
        emit(AuthenticatedError(error: e.toString()));
      }

    });

    on<LogoutEvent>((event,emit) async{

      try{

        await _auth.signOut();
        emit(Unauthenticated());
      } catch(e) {
        emit(AuthenticatedError(error: e.toString()));
      }
    });
  }
}
