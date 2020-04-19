import 'package:shopkart_frontend/models/app_state.dart';

AppState appReducer(state, action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}

userReducer(user, action) {
  return user;
}
