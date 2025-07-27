import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      child: Column(
        children: [
          // Animated loading ring
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulsing ring
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF667eea).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Main progress indicator
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF667eea),
                  ),
                  strokeWidth: 4,
                  backgroundColor: const Color(0xFF667eea).withOpacity(0.1),
                ),
              ),

              // Center icon
              RotationTransition(
                turns: _rotationController,
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Color(0xFF667eea),
                  size: 24,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Loading text with typing animation
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: 38),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              String text = 'Analyzing data and generating prediction...';
              String displayText = text.substring(
                0,
                value.clamp(0, text.length),
              );

              return Text(
                displayText,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),

          const SizedBox(height: 12),

          // Subtitle with fade in
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            builder: (context, opacity, child) {
              return Opacity(
                opacity: opacity,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF667eea).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '🤖 This may take a few moments',
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 14,
                      color: const Color(0xFF667eea),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
