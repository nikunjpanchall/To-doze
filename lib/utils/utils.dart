class Utils {
  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value!.isEmpty) {
      return 'Email address is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }
}
