import 'package:flutter/material.dart';

class SampleDataButton extends StatefulWidget {
  final VoidCallback onFillSampleData;

  const SampleDataButton({super.key, required this.onFillSampleData});

  @override
  State<SampleDataButton> createState() => _SampleDataButtonState();
}

class _SampleDataButtonState extends State<SampleDataButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 4 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() => _isHovered = true);
              _controller.forward();
            },
            onExit: (_) {
              setState(() => _isHovered = false);
              _controller.reverse();
            },
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF28a745), Color(0xFF20c997)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF28a745).withOpacity(0.3),
                          blurRadius: _isHovered ? 15 : 8,
                          offset: const Offset(0, 4),
                          spreadRadius: _isHovered ? 2 : 0,
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: widget.onFillSampleData,
                      icon: const Icon(
                        Icons.content_copy_rounded,
                        size: 18,
                      ),
                      label: Text(
                        isMobile ? '📋 Sample' : '📋 Fill Sample Data',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 16,
                          vertical: isMobile ? 8 : 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
