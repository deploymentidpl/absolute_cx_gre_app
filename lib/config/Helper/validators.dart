import 'package:get/get.dart';

class Validators {
  static String? rera(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length < 12 && value.trim().length > 5) {
        return null;
      } else {
        return "Enter valid RERA";
      }
    } else {
      return "RERA is required";
    }
  }
  static String? name(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length > 1) {
        return null;
      } else {
        return "Enter valid name";
      }
    } else {
      return "Name is required";
    }
  }

  static String? lastName(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length > 1) {
        return null;
      } else {
        return "Enter valid last name";
      }
    } else {
      return "Name is required";
    }
  }

  static String? text(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return "This field is required";
    }
  }

  // static String? rera(String? value) {
  //   if (value != null && value.isNotEmpty) {
  //     return null;
  //   } else {
  //     return "rera field is required";
  //   }
  // }

  static String? phone(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length == 10) {
        return null;
      } else {
        return "Enter valid phone number";
      }
    } else {
      return "Phone number is required";
    }
  }

  static String? unitId(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length == 10) {
        return null;
      } else {
        return "Enter valid unit number";
      }
    } else {
      return "Unit number is required";
    }
  }

  static String? num(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty) {
        return null;
      } else {
        return "Enter valid details";
      }
    } else {
      return "Field is required";
    }
  }

  static String? pinCode(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.trim().length == 6) {
        return null;
      } else {
        return "Enter valid pinCode";
      }
    } else {
      return "PinCode is required";
    }
  }

  static String? email(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.isEmail) {
        return null;
      } else {
        return "Enter valid email address";
      }
    } else {
      return "Email address is required";
    }
  }

  static String? url(String? value) {
    if (value != null) {
      if (value.trim().isNotEmpty && value.isURL) {
        return null;
      } else {
        return "Enter valid url";
      }
    } else {
      return "Url is required";
    }
  }

  static String? mom(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return "MOM is required";
    }
  }

  static String? cp(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return "CP is required";
    }
  }
}
