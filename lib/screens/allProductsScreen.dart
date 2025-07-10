import 'package:flutter/material.dart';
import 'filter_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Nike Air Force',
      'brand': "Men's Shoes",
      'price': 367.76,
      'type': 'BEST SELLER',
      'category': 'Nike',
      'gender': 'Men',
      'size': 'UK 6.5',
      'colors': [
        {
          'color': Colors.red,
          'image': 'assets/images/products/nike_air_force_red.png',
        },
        {
          'color': Colors.blue,
          'image': 'assets/images/products/nike_air_force_blue.png',
        },
      ],
      'selectedColorIndex': 0,
    },
    {
      'name': 'Nike Air Max',
      'brand': "Women's Shoes",
      'price': 254.89,
      'type': 'BEST SELLER',
      'category': 'Nike',
      'gender': 'Women',
      'size': 'UK 4.4',
      'colors': [
        {
          'color': Colors.green,
          'image': 'assets/images/products/nike_air_max_green.png',
        },
        {
          'color': Colors.white,
          'image': 'assets/images/products/nike_air_max_white.png',
        },
      ],
      'selectedColorIndex': 0,
    },
    {
      'name': 'Adidas Ultraboost',
      'brand': "Men's Shoes",
      'price': 180.00,
      'type': 'BEST SELLER',
      'category': 'Adidas',
      'gender': 'Men',
      'size': 'US 5.5',
      'colors': [
        {
          'color': Colors.black,
          'image': 'assets/images/products/adidas_ultraboost_black.png',
        },
        {
          'color': Colors.blue,
          'image': 'assets/images/products/adidas_ultraboost_blue.png',
        },
      ],
      'selectedColorIndex': 0,
    },
    {
      'name': 'Puma RS-X',
      'brand': "Unisex Shoes",
      'price': 120.00,
      'type': 'BEST SELLER',
      'category': 'Puma',
      'gender': 'Unisex',
      'size': 'EU 11.5',
      'colors': [
        {
          'color': Colors.purple,
          'image': 'assets/images/products/puma_rsx_purple.png',
        },
        {
          'color': Colors.orange,
          'image': 'assets/images/products/puma_rsx_orange.png',
        },
      ],
      'selectedColorIndex': 0,
    },
    {
      'name': 'Under Armour HOVR',
      'brand': "Men's Shoes",
      'price': 110.00,
      'type': 'BEST SELLER',
      'category': 'Under Armour',
      'gender': 'Men',
      'size': 'UK 6.5',
      'colors': [
        {
          'color': Colors.grey,
          'image': 'assets/images/products/ua_hovr_grey.png',
        },
        {
          'color': Colors.red,
          'image': 'assets/images/products/ua_hovr_red.png',
        },
      ],
      'selectedColorIndex': 0,
    },
    {
      'name': 'Converse Chuck Taylor',
      'brand': "Women's Shoes",
      'price': 60.00,
      'type': 'BEST SELLER',
      'category': 'Converse',
      'gender': 'Women',
      'size': 'UK 4.4',
      'colors': [
        {
          'color': Colors.white,
          'image': 'assets/images/products/converse_white.png',
        },
        {
          'color': Colors.black,
          'image': 'assets/images/products/converse_black.png',
        },
      ],
      'selectedColorIndex': 0,
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];
  final List<bool> favorites = [];
  Map<String, dynamic> currentFilters = {
    'category': null,
    'gender': null,
    'size': null,
    'minPrice': 16,
    'maxPrice': 350,
  };

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(allProducts);
    favorites.addAll(List.filled(allProducts.length, false));
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      currentFilters = filters;
      filteredProducts = allProducts.where((product) {
        // Category filter
        if (filters['category'] != null &&
            product['category'] != filters['category']) {
          return false;
        }

        // Gender filter
        if (filters['gender'] != null &&
            product['gender'] != filters['gender']) {
          return false;
        }

        // Size filter
        if (filters['size'] != null &&
            product['size'] != filters['size']) {
          return false;
        }

        // Price range filter
        if (product['price'] < filters['minPrice'] ||
            product['price'] > filters['maxPrice']) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _changeProductColor(int productIndex, int colorIndex) {
    setState(() {
      filteredProducts[productIndex]['selectedColorIndex'] = colorIndex;
    });
  }

  void _toggleFavorite(int index) {
    // Find the original index in allProducts
    final productName = filteredProducts[index]['name'];
    final originalIndex = allProducts.indexWhere((p) => p['name'] == productName);

    if (originalIndex != -1) {
      setState(() {
        favorites[originalIndex] = !favorites[originalIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseSize = screenWidth * 0.02;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Best Sellers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final filters = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterScreen(),
                  settings: RouteSettings(arguments: currentFilters),
                ),
              );
              if (filters != null) {
                _applyFilters(filters);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(baseSize * 1.2),
        child: filteredProducts.isEmpty
            ? const Center(
          child: Text(
            'No products match your filters',
            style: TextStyle(fontSize: 16),
          ),
        )
            : GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: baseSize * 1.2,
            mainAxisSpacing: baseSize * 1.2,
            childAspectRatio: 0.7,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            final selectedColorIndex = product['selectedColorIndex'];
            final currentImage = product['colors'][selectedColorIndex]['image'];

            // Find the original index for favorites
            final productName = product['name'];
            final originalIndex = allProducts.indexWhere((p) => p['name'] == productName);
            final isFavorite = originalIndex != -1 ? favorites[originalIndex] : false;

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          currentImage,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'BEST SELLER',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product['brand'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              product['colors'].length,
                                  (colorIndex) {
                                final isWhite = product['colors'][colorIndex]
                                ['color'] ==
                                    Colors.white;
                                return GestureDetector(
                                  onTap: () =>
                                      _changeProductColor(index, colorIndex),
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    margin: const EdgeInsets.only(left: 4),
                                    decoration: BoxDecoration(
                                      color: product['colors'][colorIndex]
                                      ['color'],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                        selectedColorIndex == colorIndex
                                            ? Colors.blue
                                            : isWhite
                                            ? Colors.grey[300]!
                                            : Colors.transparent,
                                        width:
                                        selectedColorIndex == colorIndex
                                            ? 2
                                            : 1.5,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 18,
                          color: isFavorite
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}