import 'package:flutter/material.dart';
import 'package:times_up_flutter/theme/theme.dart';

class MapMarker extends StatelessWidget {
  const MapMarker(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                scale: 0.8,
                image: NetworkImage(
                  imageUrl,
                ),
              ),
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: CustomColors.greenPrimary,
              border: Border.all(
                color: CustomColors.greenPrimary,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 60,
              color: CustomColors.greenPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(size.width / 3, 0)
      ..lineTo(size.width / 2, size.height / 3)
      ..lineTo(size.width - size.width / 3, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
