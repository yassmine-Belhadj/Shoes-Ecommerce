import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  final PageController _pageController = PageController();
  bool _isFavorite = false;
  final List<String> _productImages = [
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-force-1-07-shoes-WrLlWX.png',
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/7c1a5e1e-4a3e-4a7b-8b0a-3b3b3b3b3b3b/air-force-1-07-shoes-WrLlWX.png',
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/8c1a5e1e-4a3e-4a7b-8b0a-3b3b3b3b3b3b/air-force-1-07-shoes-WrLlWX.png',
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9c1a5e1e-4a3e-4a7b-8b0a-3b3b3b3b3b3b/air-force-1-07-shoes-WrLlWX.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Men's Shoes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Gallery
            SizedBox(
              height: isSmallScreen ? 280 : isMediumScreen ? 320 : 380,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: _productImages
                        .map((imageUrl) => Hero(
                      tag: widget.product['image'],
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ))
                        .toList(),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(_productImages.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _pageController.hasClients &&
                                _pageController.page?.round() == index
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : isMediumScreen ? 20.0 : 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // Title and Price
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen
                          ? 20
                          : isMediumScreen
                          ? 22
                          : 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${widget.product['price'].toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen
                              ? 18
                              : isMediumScreen
                              ? 20
                              : 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'BEST SELLER',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isSmallScreen ? 12 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'The radiance lives on in the Nike Air Force 1, the basketball original that puts a fresh spin on what you know best: crisp leather, bold colors and the perfect amount of flash to make you shine. The padded, low-cut collar adds a comfortable fit while the perforations on the toe keep you cool.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              const SizedBox(height: 24),

              // Gallery Section
              Text(
                'Gallery',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: isSmallScreen ? 70 : 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _productImages
                      .map((imageUrl) => _buildGalleryThumbnail(imageUrl))
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Size Selection
              Text(
                'Size',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: isSmallScreen ? 45 : 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['38', '39', '40', '41', '42', '43']
                      .map((size) => Padding(
                    padding:
                    EdgeInsets.only(right: isSmallScreen ? 6 : 8),
                    child: _buildCircularSizeOption(size),
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Price and Add to Cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      Text(
                        '\$${widget.product['price'].toStringAsFixed(2)}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen
                              ? 18
                              : isMediumScreen
                              ? 20
                              : 22,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _selectedSize == null
                        ? null
                        : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${widget.product['name']} (Size: $_selectedSize) added to cart'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen
                            ? 20
                            : isMediumScreen
                            ? 24
                            : 32,
                        vertical: isSmallScreen ? 14 : 16,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),                  const SizedBox(height: 16),
                ],
              ),
            ]),
      )],
        ),
      ),
    );
  }

  Widget _buildGalleryThumbnail(String imageUrl) {
    return GestureDetector(
      onTap: () {
        final index = _productImages.indexOf(imageUrl);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCircularSizeOption(String size) {
    final isSelected = _selectedSize == size;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final sizeDiameter = isSmallScreen ? 40.0 : 48.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        width: sizeDiameter,
        height: sizeDiameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? Colors.blue.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.black,
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }
}