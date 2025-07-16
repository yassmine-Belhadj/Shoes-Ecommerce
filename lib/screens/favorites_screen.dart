import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Favorites',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const FavoriteScreen(),
    );
  }
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // List of favorite products with their details
  final List<Map<String, dynamic>> favoriteProducts = [
    {
      'name': 'Nike Jordan',
      'price': '\$493.00',
      'image': 'assets/images/products/nike_jordan.png',
      'isBestSeller': true,
      'isFavorite': true,
    },
    {
      'name': 'Nike Air Max',
      'price': '\$897.99',
      'image': 'assets/images/products/nike_air_max.png',
      'isBestSeller': true,
      'isFavorite': true,
    },
    {
      'name': 'Nike Jordan',
      'price': '\$493.00',
      'image': 'assets/images/products/nike_jordan.png',
      'isBestSeller': false,
      'isFavorite': true,
    },
    {
      'name': 'Nike Air Max',
      'price': '\$897.99',
      'image': 'assets/images/products/nike_air_max.png',
      'isBestSeller': false,
      'isFavorite': true,
    },
  ];

  // Function to toggle favorite status
  void toggleFavorite(int index) {
    setState(() {
      favoriteProducts[index]['isFavorite'] = !favoriteProducts[index]['isFavorite'];
      // Remove from favorites if unfavorited
      if (!favoriteProducts[index]['isFavorite']) {
        favoriteProducts.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Favourite',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoriteProducts.isEmpty
            ? const Center(
          child: Text(
            'No favorites yet',
            style: TextStyle(fontSize: 18),
          ),
        )
            : LayoutBuilder(
          builder: (context, constraints) {
            // Responsive grid based on screen width
            final crossAxisCount = constraints.maxWidth > 800 ? 3 : 2;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final product = favoriteProducts[index];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    product['image'],
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if (product['isBestSeller'])
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'BEST SELLER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['price'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.white,
                                size: 18),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                product['isFavorite']
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.blue[700],
              ),
              onPressed: () => toggleFavorite(index),
            ),
          ),
        ],
      ),
    );
  }
}