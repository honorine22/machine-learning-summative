import 'package:flutter/material.dart';

class FormProgressIndicator extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final Set<int> completedSteps;

  const FormProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.completedSteps,
  });

  @override
  State<FormProgressIndicator> createState() => _FormProgressIndicatorState();
}

class _FormProgressIndicatorState extends State<FormProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Initialize the progress animation
    final initialProgress = (widget.completedSteps.length +
        (widget.currentStep == widget.totalSteps - 1 ? 1 : 0)) /
        widget.totalSteps;
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: initialProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    _controller.forward();
  }

  @override
  void didUpdateWidget(FormProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep ||
        oldWidget.completedSteps.length != widget.completedSteps.length) {
      _updateProgress();
    }
  }

  void _updateProgress() {
    final progress =
        (widget.completedSteps.length +
            (widget.currentStep == widget.totalSteps - 1 ? 1 : 0)) /
        widget.totalSteps;

    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward(from: 0);
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 6 : 8,
      ),
      child: Column(
        children: [
          // Progress bar with gradient
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFFf1f3f4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation(
                      _progressAnimation.value == 1.0
                          ? const Color(0xFF28a745)
                          : const Color(0xFF667eea),
                    ),
                    minHeight: 8,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Progress text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${widget.currentStep + 1} of ${widget.totalSteps}',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  final percentage = (_progressAnimation.value * 100).round();
                  return Text(
                    '$percentage% Complete',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      color: percentage == 100
                          ? const Color(0xFF28a745)
                          : const Color(0xFF667eea),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
