import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : (isTablet ? 900 : maxWidth),
        ),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 8 : 16,
              ),
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      margin:
          margin ??
          EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 12 : 20,
          ),
      padding: padding ?? EdgeInsets.all(isMobile ? 20 : 28),
      decoration:
          decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: isMobile ? 15 : 25,
                offset: Offset(0, isMobile ? 8 : 12),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: isMobile ? 8 : 12,
                offset: Offset(0, isMobile ? 2 : 4),
                spreadRadius: 0,
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
          ),
      child: child,
    );
  }
}
