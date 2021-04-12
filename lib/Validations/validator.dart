String pwdValidator(String value) {
  Pattern pattern = r'[0-9a-zA-Z!@#$.%^&*]{6,}';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value))
      return 'Minimum 6 characters';
    else
      return null;
  }
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(?!fodaffy)((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please enter an email id';
  } else if (value.contains("fodaffy.com")) {
    return 'fodaffy.com id\'s cannot be used.';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }
}
