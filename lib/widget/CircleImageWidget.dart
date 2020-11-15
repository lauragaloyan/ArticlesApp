import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String imageUrl;

  const CircleImageWidget(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          width: 50,
          height: 50,
          image: imageUrl,
          placeholder: "assets/icons/ic_profile_placeholder.png"),
    );
  }
}
