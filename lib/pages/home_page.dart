import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/categories.dart';
import '../widgets/section_title.dart';
import '../widgets/product_card.dart';

// BERANDA
// ---------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onToggle;
  final VoidCallback onSeeAll;
  final void Function(String) onCategory;

  const HomePage({
    super.key,
    required this.products,
    required this.onToggle,
    required this.onSeeAll,
    required this.onCategory,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    // Produk unggulan = rating tertinggi
    final featured = [...products]..sort((a, b) => b.rating.compareTo(a.rating));
    final top = featured.take(5).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // ---- Header sapaan + search ----
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo, selamat datang! 👋',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 2),
              const Text(
                'Mau cari produk apa hari ini?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                readOnly: true,
                onTap: onSeeAll,
                decoration: InputDecoration(
                  hintText: 'Cari produk...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ---- Banner promo ----
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF7E57C2), Color(0xFFEC407A)],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Promo Spesial',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Diskon hingga 30% untuk produk pilihan minggu ini.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurple,
                        ),
                        onPressed: onSeeAll,
                        child: const Text('Belanja Sekarang'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.local_offer, size: 72, color: Colors.white54),
              ],
            ),
          ),
        ),

        // ---- Kategori ----
        const SectionTitle(title: 'Kategori'),
        SizedBox(
          height: 92,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: categories.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onCategory(e.key),
                  child: SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: scheme.primaryContainer,
                          child: Icon(e.value, color: scheme.primary),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          e.key,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // ---- Produk unggulan ----
        SectionTitle(
          title: 'Produk Unggulan',
          actionLabel: 'Lihat semua',
          onAction: onSeeAll,
        ),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: top.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, i) => SizedBox(
              width: 165,
              child: ProductCard(
                product: top[i],
                onFavorite: () => onToggle(top[i]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



// ---------------------------------------------------------------------------
