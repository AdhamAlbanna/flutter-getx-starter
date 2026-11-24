import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/constants/appcolor.dart';

/// A row in the products list. Knows nothing about the controller.
class ProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  const ProductItem({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 56,
        height: 56,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              const Icon(Icons.image_not_supported_outlined),
        ),
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(
        '\$${price.toStringAsFixed(2)}',
        style: const TextStyle(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
