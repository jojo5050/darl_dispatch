import 'dart:ui';

class AppColors {

  static const Color primary = Color(0XFF0071BC);
  static const Color textFieldColor = Color(0XFFF2F8FC);
  static const Color driversCardColor = Color(0XFFFF930F);
  static const Color dashboardtextcolor = Color(0XFF0071BC);



}

extension ColorExt  on Color {
  Color disable(bool? status) {
    if(status != null && !status) {
      return this;
    }

    return withOpacity(0.5);
  }
}