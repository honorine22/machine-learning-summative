import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/app_header.dart';
import '../components/form_stepper.dart';
import '../components/loading_indicator.dart';
import '../components/error_message.dart';
import '../components/sample_data_button.dart';
import '../components/progress_indicator.dart';
import 'prediction_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _loading = false;
  String? _error;
  int _currentStep = 0;
  final Set<int> _completedSteps = {};

  // Updated to match API requirements - only 7 fields
  final List<Map<String, dynamic>> _sections = [
    {
      'title': '📚 Education Indicators',
      'icon': Icons.school,
      'fields': [
        {
          'name': 'school_enrollment_primary',
          'label': 'Primary School Enrollment (%)',
          'hint': '85.5',
          'min': 0.0,
          'max': 100.0,
        },
        {
          'name': 'school_enrollment_secondary',
          'label': 'Secondary School Enrollment (%)',
          'hint': '72.3',
          'min': 0.0,
          'max': 100.0,
        },
        {
          'name': 'literacy_rate',
          'label': 'Adult Literacy Rate (%)',
          'hint': '78.9',
          'min': 0.0,
          'max': 100.0,
        },
      ],
    },
    {
      'title': '👥 Demographics & Health',
      'icon': Icons.people,
      'fields': [
        {
          'name': 'urban_population_percent',
          'label': 'Urban Population (%)',
          'hint': '65.0',
          'min': 0.0,
          'max': 100.0,
        },
        {
          'name': 'population',
          'label': 'Total Population',
          'hint': '15000000',
          'min': 100000.0,
          'max': 2000000000.0,
        },
        {
          'name': 'life_expectancy',
          'label': 'Life Expectancy (years)',
          'hint': '68.5',
          'min': 30.0,
          'max': 90.0,
        },
      ],
    },
    {
      'title': '💰 Economic Indicators',
      'icon': Icons.attach_money,
      'fields': [
        {
          'name': 'gdp_per_capita',
          'label': 'GDP per Capita (USD)',
          'hint': '3500',
          'min': 100.0,
          'max': 100000.0,
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var section in _sections) {
      for (var field in section['fields']) {
        _controllers[field['name']] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _fillSampleData() {
    final sampleData = {
      'school_enrollment_primary': '85.5',
      'school_enrollment_secondary': '72.3',
      'literacy_rate': '78.9',
      'urban_population_percent': '65.0',
      'gdp_per_capita': '3500',
      'population': '15000000',
      'life_expectancy': '68.5',
    };

    for (var entry in sampleData.entries) {
      _controllers[entry.key]?.text = entry.value;
    }
  }

  void _markStepAsCompleted(int stepIndex) {
    setState(() {
      _completedSteps.add(stepIndex);
    });
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _loading = false;
      });
      return;
    }

    try {
      final data = <String, double>{};
      for (var section in _sections) {
        for (var field in section['fields']) {
          data[field['name']] = double.parse(_controllers[field['name']]!.text);
        }
      }

      final response = await http.post(
        Uri.parse(
          'https://machine-learning-summative-3fgi.onrender.com/predict',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        // Navigate to prediction screen with the result
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PredictionScreen(result: result),
            ),
          );
        }
      } else {
        setState(() {
          _error = jsonDecode(response.body)['detail'] ?? 'Prediction failed.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Component
            const AppHeader(),

            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Sample Data Button Component
                  SampleDataButton(onFillSampleData: _fillSampleData),

                  // Progress Indicator
                  FormProgressIndicator(
                    currentStep: _currentStep,
                    totalSteps: _sections.length,
                    completedSteps: _completedSteps,
                  ),

                  // Stepper Form Component
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: FormStepper(
                        sections: _sections,
                        controllers: _controllers,
                        currentStep: _currentStep,
                        completedSteps: _completedSteps,
                        onStepContinue: () {
                          if (_currentStep < _sections.length - 1) {
                            _markStepAsCompleted(_currentStep);
                            setState(() {
                              _currentStep++;
                            });
                          } else {
                            _markStepAsCompleted(_currentStep);
                            _submit();
                          }
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() {
                              _currentStep--;
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  // Loading Component
                  if (_loading) const LoadingIndicator(),

                  // Error Component
                  if (_error != null) ErrorMessage(error: _error!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 