import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageNetworkWrapper extends StatelessWidget {
  const ImageNetworkWrapper({
    this.imageUrl,
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
  });
  final String? imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Image.asset(
            "assets/images/No-image-available.png",
            width: width,
            height: height,
            fit: BoxFit.cover,
            frameBuilder: _frameBuilder,
            errorBuilder: _buildError,
          )
        : Image.network(
            imageUrl!,
            frameBuilder: _frameBuilder,
            errorBuilder: _buildError,
            fit: BoxFit.cover,
            height: height,
            width: width,
            loadingBuilder: _loadingBuilder,
          );
  }

  Widget _buildError(
          BuildContext context, Object error, StackTrace? stackTrace) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/images/No-image-available.png",
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );

  Widget _loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _frameBuilder(BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      );
}
