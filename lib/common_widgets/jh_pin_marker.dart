import 'package:flutter/material.dart';
import 'package:parental_control/theme/theme.dart';

class MapMarker extends StatelessWidget {
  final String imageUrl;
  MapMarker(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                scale: 0.8,
                image: NetworkImage(
                  imageUrl,
                ),
              ),
              color: Colors.red,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            height: 6.0,
            decoration: BoxDecoration(
              color: CustomColors.greenPrimary,
              border: Border.all(
                color: CustomColors.greenPrimary,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 60.0,
              color: CustomColors.greenPrimary,
            ),
          )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 3, 0.0);
    path.lineTo(size.width / 2, size.height / 3);
    path.lineTo(size.width - size.width / 3, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
