import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_grid.dart';

// KATALOG (dengan filter kategori)
// ---------------------------------------------------------------------------
class CatalogPage extends StatelessWidget {
  final List<Product> products;
  final String? category;
  final VoidCallback onClearCategory;
  final void Function(Product) onToggle;

  const CatalogPage({
    super.key,
    required this.products,
    required this.category,
    required this.onClearCategory,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final shown = category == null
        ? products
        : products.where((p) => p.category == category).toList();

    return Column(
      children: [
        if (category != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: InputChip(
                label: Text('Kategori: $category'),
                onDeleted: onClearCategory,
              ),
            ),
          ),
        Expanded(
          child: ProductGrid(
            products: shown,
            onToggle: onToggle,
            emptyMessage: 'Produk tidak ditemukan.',
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
