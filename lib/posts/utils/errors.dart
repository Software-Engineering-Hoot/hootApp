class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
      case 'account-exists-with-different-credential':
      case 'email-already-in-use':
        return 'Email already used. Go to login page.';
      case 'ERROR_WRONG_PASSWORD':
      case 'wrong-password':
        return 'Wrong email/password combination.';
      case 'ERROR_USER_NOT_FOUND':
      case 'user-not-found':
        return 'No user found with this email.';
      case 'ERROR_USER_DISABLED':
      case 'user-disabled':
        return 'User disabled.';
      case 'ERROR_TOO_MANY_REQUESTS':
      case 'operation-not-allowed':
        return 'Too many requests to log into this account.';
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'Server error, please try again later.';
      case 'ERROR_INVALID_EMAIL':
      case 'invalid-email':
        return 'Email address is invalid.';
      case 'Not_Verified':
        return 'Email is not verified, please verify your email.';
      case 'Please_Verify':
        return 'Account is created, please verify your email.';
      case 'Reset_Verify':
        return 'Email reset link sended your email, please check.';
      case 'Insert_Advert':
        return 'Advert is added.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}
