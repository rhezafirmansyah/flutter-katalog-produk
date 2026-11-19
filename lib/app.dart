import 'package:flutter/material.dart';
import 'models/product.dart';
import 'pages/home_page.dart';
import 'pages/catalog_page.dart';
import 'widgets/product_grid.dart';

// APLIKASI + TEMA
// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Produk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F1FA),
      ),
      home: const MainShell(),
    );
  }
}

// ---------------------------------------------------------------------------

// SHELL: menyimpan state bersama + bottom navigation
// ---------------------------------------------------------------------------
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tabIndex = 0; // 0 Beranda, 1 Katalog, 2 Favorit
  String? selectedCategory;

  final List<Product> products = [
    Product(
        name: 'Tas Ransel',
        category: 'Tas',
        price: 250000,
        rating: 4.5,
        icon: Icons.backpack,
        color: Colors.brown,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Sepatu Sneaker',
        category: 'Sepatu',
        price: 450000,
        rating: 4.8,
        icon: Icons.directions_run,
        color: Colors.blueGrey,
        imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Headphone',
        category: 'Audio',
        price: 350000,
        rating: 4.6,
        icon: Icons.headphones,
        color: Colors.indigo,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Smartwatch',
        category: 'Wearable',
        price: 750000,
        rating: 4.7,
        icon: Icons.watch,
        color: Colors.teal,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Kamera Mirrorless',
        category: 'Elektronik',
        price: 5500000,
        rating: 4.9,
        icon: Icons.photo_camera,
        color: Colors.deepOrange,
        imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Keyboard Mekanik',
        category: 'Elektronik',
        price: 600000,
        rating: 4.4,
        icon: Icons.keyboard,
        color: Colors.green,
        imageUrl: 'https://images.unsplash.com/photo-1595225476474-87563907a212?auto=format&fit=crop&w=600&q=80'),
    Product(
        name: 'Speaker Bluetooth',
        category: 'Audio',
        price: 300000,
        rating: 4.3,
        icon: Icons.speaker,
        color: Colors.pink,
        imageUrl: 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=600&q=80'),
  ];

  void toggleFavorite(Product p) {
    setState(() => p.isFavorite = !p.isFavorite);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              Icon(
                p.isFavorite ? Icons.check_circle : Icons.info_outline,
                color: p.isFavorite ? Colors.greenAccent : Colors.white70,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(p.isFavorite
                    ? '${p.name} ditambahkan ke Favorit'
                    : '${p.name} dihapus dari Favorit'),
              ),
            ],
          ),
        ),
      );
  }

  void goToCatalog({String? category}) {
    setState(() {
      selectedCategory = category;
      tabIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = products.where((p) => p.isFavorite).toList();
    const titles = ['Beranda', 'Katalog Produk', 'Favorit'];

    final pages = <Widget>[
      HomePage(
        products: products,
        onToggle: toggleFavorite,
        onSeeAll: () => goToCatalog(),
        onCategory: (c) => goToCatalog(category: c),
      ),
      CatalogPage(
        products: products,
        category: selectedCategory,
        onClearCategory: () => setState(() => selectedCategory = null),
        onToggle: toggleFavorite,
      ),
      ProductGrid(
        products: favorites,
        onToggle: toggleFavorite,
        emptyMessage: 'Belum ada produk favorit.\nTekan ikon hati pada produk.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[tabIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: pages[tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        onDestinationSelected: (i) => setState(() {
          tabIndex = i;
          if (i != 1) selectedCategory = null;
        }),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: favorites.isNotEmpty,
              label: Text('${favorites.length}'),
              child: const Icon(Icons.favorite_border),
            ),
            selectedIcon: Badge(
              isLabelVisible: favorites.isNotEmpty,
              label: Text('${favorites.length}'),
              child: const Icon(Icons.favorite),
            ),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
