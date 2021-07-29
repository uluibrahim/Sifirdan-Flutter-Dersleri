import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final double yukseklik;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double fontSize;
  final Widget? buttonIcon;
  final VoidCallback onPressed;

  SocialLoginButton({
    required this.buttonText,
    this.buttonColor: Colors.blue,
    this.textColor: Colors.white,
    this.radius: 16,
    this.yukseklik: 50,
    this.fontSize: 17,
    this.buttonIcon,
    required this.onPressed,
    // assert ile buton textin null kullanılmaya çalışılması halinde hatanın kaynağını göstermiş olduk
  }) : assert(buttonText != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: yukseklik,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Spreads, collection-if, collection-for
            if (buttonIcon != null) ...[
              buttonIcon!,
              Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
              Opacity(opacity: 0, child: buttonIcon),
            ],
            if (buttonIcon == null) ...[
              SizedBox(),
              Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
              Opacity(opacity: 0, child: SizedBox()),
            ]
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      ),
    );
  }
}
