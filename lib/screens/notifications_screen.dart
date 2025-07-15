import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  // Sample notification data
  List<Map<String, dynamic>> todayNotifications = [
    {
      'title': 'We Have New Products With Offers',
      'originalPrice': '\$364.95',
      'discountedPrice': '\$260.00',
      'time': '6 min ago',
      'image': 'nike_jordan.png',
    },
    {
      'title': 'We Have New Products With Offers',
      'originalPrice': '\$364.95',
      'discountedPrice': '\$260.00',
      'time': '26 min ago',
      'image': 'nike_air_max.png',
    },
  ];

  List<Map<String, dynamic>> yesterdayNotifications = [
    {
      'title': 'We Have New Products With Offers',
      'originalPrice': '\$364.95',
      'discountedPrice': '\$260.00',
      'time': '4 day ago',
      'image': 'nike_air_jordan.png',
    },
    {
      'title': 'We Have New Products With Offers',
      'originalPrice': '\$364.95',
      'discountedPrice': '\$260.00',
      'time': '4 day ago',
      'image': 'nike_jordan.png',
    },
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Start animations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1).animate(
            CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.easeOutBack,
            ),
          ),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeInOut,
              ),
            ),
            child: AlertDialog(
              title: const Text('Clear All Notifications'),
              content: const Text('Are you sure you want to clear all notifications?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _animateClearAll();
                  },
                  child: const Text('Clear', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _animateClearAll() {
    _animationController.reverse().then((_) {
      setState(() {
        todayNotifications.clear();
        yesterdayNotifications.clear();
      });
      _animationController.forward();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All notifications cleared'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          elevation: 6,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: todayNotifications.isEmpty && yesterdayNotifications.isEmpty
                ? null
                : _clearAllNotifications,
            child: const Text(
              'Clear All',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (todayNotifications.isNotEmpty)
                  _buildNotificationSection("Today", todayNotifications),
                if (yesterdayNotifications.isNotEmpty)
                  _buildNotificationSection("Yesterday", yesterdayNotifications),
                if (todayNotifications.isEmpty && yesterdayNotifications.isEmpty)
                  _buildEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSection(String title, List<Map<String, dynamic>> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: List.generate(notifications.length, (index) {
            final notification = notifications[index];
            return AnimatedNotificationItem(
              index: index,
              title: notification['title'],
              originalPrice: notification['originalPrice'],
              discountedPrice: notification['discountedPrice'],
              time: notification['time'],
              imageName: notification['image'],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.elasticOut,
              ),
            ),
            child: const Icon(
              Icons.notifications_off,
              size: 60,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedNotificationItem extends StatefulWidget {
  final int index;
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final String time;
  final String imageName;

  const AnimatedNotificationItem({
    super.key,
    required this.index,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.time,
    required this.imageName,
  });

  @override
  _AnimatedNotificationItemState createState() => _AnimatedNotificationItemState();
}

class _AnimatedNotificationItemState extends State<AnimatedNotificationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Start animation after a small delay based on index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildNotificationItem(),
      ),
    );
  }

  Widget _buildNotificationItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'notification_image_${widget.imageName}',
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/products/${widget.imageName}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      widget.originalPrice,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      widget.discountedPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            widget.time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}