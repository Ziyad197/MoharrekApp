import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? width;
  final double? height;
  final bool isLoading;

  final VoidCallback onPressed;

  const CustomeButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed,
      required this.isLoading,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: onPressed,
        child: isLoading
            ? Container(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$text",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
        color: color,
        padding: EdgeInsets.symmetric(vertical: height ?? 10),
      ),
    );
  }
}

class CustomeButtonIcon extends StatelessWidget {
  final String text;
  final Color textColor;
  final double width;
  final Color buttonColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomeButtonIcon(
      {super.key,
      required this.text,
      required this.width,
      required this.buttonColor,
      required this.icon,
      required this.onPressed,
      required this.isLoading,
      required this.textColor,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: onPressed,
        color: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: isLoading
            ? Container(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 20,
                    width: 20,
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class CustomeUploadButtonIcon extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomeUploadButtonIcon(
      {super.key,
      required this.text,
      required this.color,
      required this.icon,
      required this.onPressed,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: onPressed,
        color: color,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: isLoading
            ? Container(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 20,
                    width: 20,
                    child: Icon(icon, color: Colors.white),
                  )
                ],
              ),
      ),
    );
  }
}
