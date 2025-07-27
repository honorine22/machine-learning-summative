import 'package:flutter/material.dart';

class PredictionResult extends StatelessWidget {
  final Map<String, dynamic> result;

  const PredictionResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      margin: EdgeInsets.all(isMobile ? 4 : 8),
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header,
          const ResultHeader(),
          const SizedBox(height: 12),
          // Prediction Value
          Center(
            child: Text(
              '${result['predicted_employment_rate']?.toStringAsFixed(2) ?? 'N/A'}%',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF667eea),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Confidence Badge
          Center(
            child: ConfidenceBadge(
              confidenceLevel:
                  result['confidence_level']?.toString() ?? 'Unknown',
            ),
          ),

          const SizedBox(height: 12),

          // Details Grid
          ResultDetailsGrid(result: result),
        ],
      ),
    );
  }
}

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Row(
      children: [
        Container(
          width: isMobile ? 32 : 40,
          height: isMobile ? 32 : 40,
          decoration: const BoxDecoration(
            color: Color(0xFF667eea),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Icon(
            Icons.analytics,
            color: Colors.white,
            size: isMobile ? 16 : 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Prediction Results',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
}

class ConfidenceBadge extends StatelessWidget {
  final String confidenceLevel;

  const ConfidenceBadge({super.key, required this.confidenceLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getConfidenceColor(confidenceLevel),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$confidenceLevel Confidence',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _getConfidenceTextColor(confidenceLevel),
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getConfidenceColor(String confidence) {
    switch (confidence.toLowerCase()) {
      case 'high':
        return const Color(0xFFd4edda);
      case 'medium':
        return const Color(0xFFfff3cd);
      case 'low':
        return const Color(0xFFf8d7da);
      default:
        return const Color(0xFFe9ecef);
    }
  }

  Color _getConfidenceTextColor(String confidence) {
    switch (confidence.toLowerCase()) {
      case 'high':
        return const Color(0xFF155724);
      case 'medium':
        return const Color(0xFF856404);
      case 'low':
        return const Color(0xFF721c24);
      default:
        return const Color(0xFF6c757d);
    }
  }
}

class ResultDetailsGrid extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultDetailsGrid({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      children: [
        // Row 1: Model Used
        SizedBox(
          height: 80,
          child: DetailCard(
            title: 'Model Used',
            value: result['model_used']?.toString() ?? 'Unknown',
            icon: Icons.psychology,
          ),
        ),

        const SizedBox(height: 8),

        // Row 2: Input Summary (Horizontal Scrollable)
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                (result['input_summary'] as Map<String, dynamic>?)?.entries
                    .map<Widget>(
                      (e) => Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 8),
                        child: DetailCard(
                          title: e.key.replaceAll('_', ' ').toUpperCase(),
                          value: e.value?.toString() ?? 'N/A',
                          icon: _getSummaryIcon(e.key),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),

        const SizedBox(height: 8),

        // Row 3: Feature Importance (Horizontal Scrollable)
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                (result['feature_importance'] as Map<String, dynamic>?)?.entries
                    .map<Widget>(
                      (e) => Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 8),
                        child: DetailCard(
                          title:
                              '${e.key.replaceAll('_', ' ').toUpperCase()} IMPORTANCE',
                          value:
                              '${(e.value is num) ? (e.value as num).toStringAsFixed(1) : e.value?.toString() ?? 'N/A'}%',
                          icon: Icons.trending_up,
                          isImportance: true,
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ],
    );
  }

  IconData _getSummaryIcon(String key) {
    switch (key) {
      case 'education':
        return Icons.school;
      case 'demographics':
        return Icons.people;
      case 'economy':
        return Icons.attach_money;
      case 'technology':
        return Icons.wifi;
      default:
        return Icons.info;
    }
  }
}

class DetailCard extends StatelessWidget {
  final String title;
  final dynamic value;
  final IconData icon;
  final bool isImportance;

  const DetailCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.isImportance = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFe1e5e9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: isMobile ? 14 : 16,
                color: isImportance
                    ? const Color(0xFF28a745)
                    : const Color(0xFF667eea),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF555555),
                    fontSize: isMobile ? 9 : 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Flexible(
            child: Text(
              value.toString(),
              style: TextStyle(
                color: isImportance
                    ? const Color(0xFF28a745)
                    : const Color(0xFF333333),
                fontSize: isMobile ? 11 : 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
