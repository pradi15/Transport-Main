class Validating {
  static Future<String> ValidingStudentRegisterForm(
      String emailController,
      String passwordController,
      String retyepasswordController,
      String _myRole,
      String _myLocationName) async {
    String result;

    if (emailController.isEmpty) {
      result = "Email Is Empty";
    } else if (!emailController.endsWith('.com')) {
      result = 'Email Format is wrong';
    } else if (passwordController.isEmpty) {
      result = 'Password is Empty';
    } else if (passwordController.length < 6) {
      result = 'Password Should be Greater Than 6';
    } else if (retyepasswordController.isEmpty) {
      result = 'ReType Password is Empty';
    } else if (passwordController != retyepasswordController) {
      result = "Typed Password Did not Match";
    } else if (_myRole == "null") {
      result = 'Please Choose Role!';
    } else if (_myLocationName == "null") {
      result = 'Please choose BusLocation';
    } else {
      return result = 'Success';
    }
    return result;
  }

  static Future<String> ValidingDriverRegisterForm(
      String emailController,
      String passwordController,
      String retypasswordController,
      String _myRole,
      String _busController) async {
    String result;

    if (emailController.isEmpty) {
      result = "Email Is Empty";
    } else if (!emailController.endsWith('.com')) {
      result = 'Email Format is wrong';
    } else if (passwordController.isEmpty) {
      result = 'Password is Empty';
    } else if (passwordController.length < 6) {
      result = 'Password Should be Greater Than 6';
    } else if (retypasswordController.isEmpty) {
      result = 'ReType Password is Empty';
    } else if (passwordController != retypasswordController) {
      result = "Typed Password Did not Match";
    } else if (_myRole == "null") {
      result = 'Please Choose Role!';
    } else if (_busController.isEmpty) {
      result = 'Please Type Bus Name';
    } else {
      return result = 'Success';
    }
    return result;
  }
}
