import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Primary and Secondary Texts
class AppFonts {
  static TextStyle primaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static TextStyle secondaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 14,
        color: Color(0xff39FF14),
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

//Custom Textstyle
TextStyle fontStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.rethinkSans(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

//Custom Apptheme
class AppTheme {
  static ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headline1:
          TextStyle(color: Colors.white), // Change primary text color to white
      headline2:
          TextStyle(color: Colors.white), // Change primary text color to white
      headline3:
          TextStyle(color: Colors.white), // Change primary text color to white
      headline4:
          TextStyle(color: Colors.white), // Change primary text color to white
      headline5:
          TextStyle(color: Colors.white), // Change primary text color to white
      headline6:
          TextStyle(color: Colors.white), // Change primary text color to white
      subtitle1:
          TextStyle(color: Colors.white), // Change primary text color to white
      subtitle2:
          TextStyle(color: Colors.white), // Change primary text color to white
      bodyText1:
          TextStyle(color: Colors.white), // Change primary text color to white
      bodyText2:
          TextStyle(color: Colors.white), // Change primary text color to white
      caption:
          TextStyle(color: Colors.white), // Change primary text color to white
      button:
          TextStyle(color: Colors.white), // Change primary text color to white
      overline:
          TextStyle(color: Colors.white), // Change primary text color to white
    ), // Set background color for all pages
  );
}

//Custom Appbar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onBack;

  const MyAppBar({
    Key? key,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: onBack != null
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: onBack,
            )
          : null,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
