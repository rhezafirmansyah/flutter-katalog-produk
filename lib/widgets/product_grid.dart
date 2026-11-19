import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_card.dart';

// GRID RESPONSIF (2 kolom ponsel, 3 kolom layar lebar)
// ---------------------------------------------------------------------------
class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onToggle;
  final String emptyMessage;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onToggle,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.78,
          ),
          itemCount: products.length,
          itemBuilder: (context, i) => ProductCard(
            product: products[i],
            onFavorite: () => onToggle(products[i]),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
