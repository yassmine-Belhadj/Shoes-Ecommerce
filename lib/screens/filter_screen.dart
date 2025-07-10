import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedGender;
  String? selectedSize;
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(16, 350);
  final double minPrice = 16;
  final double maxPrice = 350;

  final List<String> genders = ['Men', 'Women', 'Unisex'];
  final List<String> sizes = ['UK 4.4', 'US 5.5', 'UK 6.5', 'EU 11.5'];
  final List<String> categories = ['Nike', 'Adidas', 'Puma', 'Under Armour', 'Converse'];
  final List<String> categoryImages = [
    'nike.png',
    'adidas.png',
    'puma.png',
    'underarmour.png',
    'converse.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header section
          _buildHeaderSection(),
          // Filter content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Categories Filter
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final isSelected = selectedCategory == categories[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = isSelected ? null : categories[index];
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
                                    errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.category, size: 24),
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
                    const SizedBox(height: 24),

                    // Popular Shoes section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Shoes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Filters title section
                    Stack(
                      children: [
                        const Center(
                          child: Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                selectedGender = null;
                                selectedSize = null;
                                selectedCategory = null;
                                priceRange = RangeValues(minPrice, maxPrice);
                              });
                            },
                            child: const Text(
                              'RESET',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Gender Filter
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: genders.map((gender) {
                        final isSelected = selectedGender == gender;
                        return ChoiceChip(
                          label: Text(gender),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedGender = selected ? gender : null;
                            });
                          },
                          selectedColor: Colors.blue.withOpacity(0.2),
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontSize: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected ? Colors.blue : Colors.grey[300]!,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Size Filter
                    const Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: sizes.map((size) {
                        final isSelected = selectedSize == size;
                        return ChoiceChip(
                          label: Text(size),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedSize = selected ? size : null;
                            });
                          },
                          selectedColor: Colors.blue.withOpacity(0.2),
                          backgroundColor: Colors.grey[200],
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                            fontSize: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected ? Colors.blue : Colors.grey[300]!,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Price Filter
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RangeSlider(
                      values: priceRange,
                      min: minPrice,
                      max: maxPrice,
                      divisions: 10,
                      labels: RangeLabels(
                        '\$${priceRange.start.round()}',
                        '\$${priceRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${priceRange.start.round()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '\$${priceRange.end.round()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'category': selectedCategory,
                    'gender': selectedGender,
                    'size': selectedSize,
                    'minPrice': priceRange.start,
                    'maxPrice': priceRange.end,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'APPLY',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      blurRadius: 4,
      spreadRadius: 1,
      offset: const Offset(0, 2),
      )],
    ),
    child: Column(
    children: [
    const SizedBox(height: 8),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.pop(context),
    ),
    const Expanded(
    child: Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Text(
    'Store location',
    style: TextStyle(
    fontSize: 12,
    color: Colors.grey,
    ),
    ),
    SizedBox(height: 2),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(Icons.location_on, size: 16, color: Colors.orange),
    SizedBox(width: 4),
    Text(
    'Mondolibug, Sylhet',
    style: TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.bold,
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
    const SizedBox(height: 8),
    Container(
    height: 50,
    decoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.1),
    borderRadius: BorderRadius.circular(12),
    ),
    child: const TextField(
    decoration: InputDecoration(
    border: InputBorder.none,
    prefixIcon: Icon(Icons.search, color: Colors.grey),
    hintText: 'Looking for shoes',
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    ),
    ),
    ),
    const SizedBox(height: 8),
    ],
    ),
    );
    }
}