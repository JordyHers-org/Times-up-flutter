import 'package:flutter/material.dart';

class Kids extends StatelessWidget {
  const Kids({
    this.imageLocation,
    this.imageCaption,
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final String? imageLocation;
  final String? imageCaption;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: imageLocation != null || imageCaption != null
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 130,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (imageLocation != null)
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.14),
                        image: DecorationImage(
                          image: NetworkImage(imageLocation!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  else
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.14),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: 200,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Colors.black.withOpacity(0.10),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
    );
  }
}
