import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  final String error;

  const ErrorMessage({super.key, required this.error});

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _shakeAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));

    _controller.forward();
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

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Container(
              margin: EdgeInsets.all(isMobile ? 16 : 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFffe6e6), Color(0xFFfff0f0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFdc3545).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFdc3545).withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Left accent bar
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFdc3545), Color(0xFFc82333)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(isMobile ? 16 : 20),
                      child: Row(
                        children: [
                          // Animated error icon
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return Transform.rotate(
                                angle: value * 0.1,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFdc3545,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    color: const Color(0xFFdc3545),
                                    size: isMobile ? 24 : 28,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 16),

                          // Error text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Error',
                                  style: TextStyle(
                                    color: const Color(0xFFdc3545),
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 14 : 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.error,
                                  style: TextStyle(
                                    color: const Color(0xFF721c24),
                                    fontSize: isMobile ? 13 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
