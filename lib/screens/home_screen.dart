import 'package:aftercode/screens/AccountSettingsScreen.dart';
import 'package:aftercode/screens/ProfileScreen.dart';
import 'package:aftercode/screens/allProductsScreen.dart';
import 'package:aftercode/screens/favorites_screen.dart';
import 'package:aftercode/screens/notifications_screen.dart';
import 'package:aftercode/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 2; // Shop tab highlighted by default
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      body: const HomeTabScreen(),
      bottomNavigationBar: SizedBox(
        height: 80.0, // Increased height to accommodate labels
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: _page,
              height: 60.0,
              items: const <Widget>[
                Icon(Icons.home_outlined, size: 28),
                Icon(Icons.favorite_border, size: 28),
                Icon(Icons.shopping_bag_outlined, size: 28),
                Icon(Icons.notifications_none_sharp, size: 28),
                Icon(Icons.person_outline, size: 28),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.blue[600],
              backgroundColor: Colors.blueAccent, // Fixed to a solid Color
              animationCurve: Curves.easeOutCubic,
              animationDuration: const Duration(milliseconds: 600),
              onTap: (int index) {
                setState(() {
                  _page = index;
                });
                String? route;
                switch (index) {
                  case 0:
                    return; // Stay on home screen
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FavoriteScreen()),
                    );
                    return;                    break;
                  case 2:
                    route = '/shop';
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationScreen()),
                    );
                    return; // Exit early to prevent route push
                  case 4:
                    route = '/account-settings';
                    break;
                }
                if (route != null) {
                  Navigator.pushNamed(context, route);
                }
              },
            ),
            // Custom label row
            Container(
              height: 20.0,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLabel("Home", 0),
                  _buildLabel("Wishlist", 1),
                  _buildLabel("Shop", 2),
                  _buildLabel("Notifications", 3),
                  _buildLabel("Profile", 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: _page == index ? FontWeight.bold : FontWeight.normal,
        color: _page == index ? Colors.white : Colors.grey[600],
      ),
    );
  }
}

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int _selectedCategoryIndex = 0;
  bool _showFullScreenSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _searchHistory = [
    'Nike Air Max Shoes',
    'Nike Jordan Shoes',
    'Nike Air Force Shoes',
    'Nike Club Max Shoes',
    'Snickers Nike Shoes',
    'Regular Shoes'
  ];

  final List<String> categories = ['Nike', 'Adidas', 'Puma', 'Under Armour', 'Converse'];
  final List<String> categoryImages = [
    'nike.png',
    'adidas.png',
    'puma.png',
    'underarmour.png',
    'converse.png',
  ];

  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'Nike Jordan',
      'price': 483.00,
      'type': 'BEST SELLER',
      'image': 'nike_jordan.png',
      'brand': 'Nike'
    },
    {
      'name': 'Nike Air Max',
      'price': 897.99,
      'type': 'BEST SELLER',
      'image': 'nike_air_max.png',
      'brand': 'Nike'
    },
    {
      'name': 'Nike Air Jordan',
      'price': 849.69,
      'type': 'BEST CHOICE',
      'image': 'nike_air_jordan.png',
      'brand': 'Nike'
    },
    {
      'name': 'Adidas Ultraboost',
      'price': 180.00,
      'type': 'RUNNING',
      'image': 'adidas_ultraboost.png',
      'brand': 'Adidas'
    },
    {
      'name': 'Puma RS-X',
      'price': 120.00,
      'type': 'CASUAL',
      'image': 'puma_rsx.png',
      'brand': 'Puma'
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (_searchController.text.isEmpty) return [];
    return allProducts.where((product) {
      return product['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          product['brand'].toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() {
          _showFullScreenSearch = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      appBar: _showFullScreenSearch ? null : AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.grid_view, color: Colors.black),
              onPressed: () async {
                final filters = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilterScreen()),
                );
                if (filters != null) {
                  print('Applied filters: $filters');
                }
              },
            ),
            Flexible(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Store location',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 10 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'Mondolibug, Sylhet',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
                  onPressed: () {},
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _showFullScreenSearch ? _buildFullScreenSearch() : _buildMainContent(isSmallScreen),
    );
  }

  Widget _buildMainContent(bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16.0 : 24.0,
        vertical: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 20),
          Container(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 20.0 : 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: Colors.blue, width: 1)
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/categories/${categoryImages[index]}',
                          width: 24,
                          height: 24,
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 8),
                          Text(
                            categories[index],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Shoes',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllProductsScreen()),
                  );
                },
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: constraints.maxWidth > 600 ? 350 : 300,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: _buildProductCard(allProducts[0]),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: _buildProductCard(allProducts[1]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: constraints.maxWidth > 600 ? 400 : 350,
                        child: _buildFeaturedProductCard(allProducts[2]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showFullScreenSearch = true;
          _searchFocusNode.requestFocus();
        });
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 12.0),
              child: Icon(Icons.search, color: Colors.grey),
            ),
            const Text(
              'Looking for shoes',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenSearch() {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search Your Shoes',
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                if (value.isNotEmpty && !_searchHistory.contains(value)) {
                  setState(() {
                    _searchHistory.insert(0, value);
                    if (_searchHistory.length > 10) {
                      _searchHistory.removeLast();
                    }
                  });
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _searchFocusNode.unfocus();
                setState(() {
                  _showFullScreenSearch = false;
                });
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
        Expanded(
          child: _searchController.text.isEmpty
              ? _buildSearchHistory()
              : filteredProducts.isEmpty
              ? const Center(
            child: Text(
              'No products found',
              style: TextStyle(color: Colors.grey),
            ),
          )
              : _buildSearchResults(),
        ),
      ],
    );
  }

  Widget _buildSearchHistory() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_searchHistory.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchHistory.clear();
                  });
                },
                child: const Text(
                  'Clear all',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (_searchHistory.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No recent searches',
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          Column(
            children: _searchHistory.map((search) => ListTile(
              leading: const Icon(Icons.history, color: Colors.grey),
              title: Text(search),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: () {
                  setState(() {
                    _searchHistory.remove(search);
                  });
                },
              ),
              onTap: () {
                _searchController.text = search;
                setState(() {});
              },
            )).toList(),
          ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: Image.asset(
            'assets/images/products/${product['image']}',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          title: Text(product['name']),
          subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to product detail or perform action
          },
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product['type'],
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/products/${product['image']}',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product['price'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductCard(Map<String, dynamic> product) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product['type'],
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Hero(
                    tag: product['image'],
                    child: Image.asset(
                      'assets/images/products/${product['image']}',
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 24),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}