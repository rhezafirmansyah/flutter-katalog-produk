import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/format_rupiah.dart';

// KARTU PRODUK
// ---------------------------------------------------------------------------
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onFavorite,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: product.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Image.network(
                  product.imageUrl,
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Icon(product.icon, size: 64, color: product.color);
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(product.icon, size: 64, color: product.color),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 2),
            Text(
              formatRupiah(product.price),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(
                  product.rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
