import 'package:flutter/material.dart';

// This is our new screen for converting temperature!
class TemperatureConverterScreen extends StatefulWidget {
    const TemperatureConverterScreen({super.key});

    @override
    State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
    //keep track of the user input
    double _inputValue = 0;
    //keep track of the selected input unit
    final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];
    String _fromUnit = 'Celsius';
    String _toUnit = 'Fahrenheit';
    double? _convertedValue;
    String? _message;
    bool _showHot = false;
    bool _showCold = false;

    //convert the temperature
    double _convertTemperature(double value, String fromUnit, String toUnit) {
        if (fromUnit == toUnit) return value;
        if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
            return (value * 9/5) + 32;
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
            return (value - 32) * 5/9;
        } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
            return value + 273.15;
        } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
            return value - 273.15;
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Kelvin') {
            return ((value - 32) * 5 / 9) + 273.15;
        } else if (fromUnit == 'Kelvin' && toUnit == 'Fahrenheit') {
            return ((value - 273.15) * 9 / 5) + 32;
        }
        return value;
    }

    void _convert() {
        double result = _convertTemperature(_inputValue, _fromUnit, _toUnit);
        setState(() {
            _convertedValue = result;
            if ((result > 40 && _toUnit == 'Celsius') ||
                (result > 104 && _toUnit == 'Fahrenheit') ||
                (result > 313.15 && _toUnit == 'Kelvin')) {
                _showHot = true;
                _showCold = false;
                _message = "It's too hot! ☀️";
            } else if ((result < 0 && _toUnit == 'Celsius') ||
                (result < 32 && _toUnit == 'Fahrenheit') ||
                (result < 273.15 && _toUnit == 'Kelvin')) {
                _showHot = false;
                _showCold = true;
                _message = "It's too cold! ❄️";
            } else {
                _showHot = false;
                _showCold = false;
                _message = null;
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Temperature Converter'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        // Input field
                        TextField(
                            decoration: const InputDecoration(
                                labelText: 'Enter value',
                                border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                                setState(() {
                                    _inputValue = double.tryParse(value) ?? 0;
                                });
                                _convert();
                            },
                        ),
                        const SizedBox(height: 16),
                        // Unit selection
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                const Text('From: '),
                                DropdownButton<String>(
                                    value: _fromUnit,
                                    items: _units.map((unit) {
                                        return DropdownMenuItem<String>(
                                            value: unit,
                                            child: Text(unit),
                                        );
                                    }).toList(),
                                    onChanged: (value) {
                                        setState(() {
                                            _fromUnit = value!;
                                        });
                                        _convert();
                                    },
                                ),
                                const SizedBox(width: 16),
                                const Text('To: '),
                                DropdownButton<String>(
                                    value: _toUnit,
                                    items: _units.map((unit) {
                                        return DropdownMenuItem<String>(
                                            value: unit,
                                            child: Text(unit),
                                        );
                                    }).toList(),
                                    onChanged: (value) {
                                        setState(() {
                                            _toUnit = value!;
                                        });
                                        _convert();
                                    },
                                ),
                            ],
                        ),
                        const SizedBox(height: 32),
                        // Show result
                        if (_convertedValue != null)
                            Text(
                                'Result: ${_convertedValue!.toStringAsFixed(2)} $_toUnit',
                                style: const TextStyle(fontSize: 24),
                            ),
                        const SizedBox(height: 24),
                        // Hot animation
                        if (_showHot)
                            Column(
                                children: [
                                    AnimatedRotation(
                                        turns: 1,
                                        duration: const Duration(seconds: 2),
                                        child: const Icon(Icons.wb_sunny, color: Colors.orange, size: 64),
                                    ),
                                    Text(_message!, style: const TextStyle(fontSize: 20, color: Colors.orange)),
                                ],
                            ),
                        // Cold animation
                        if (_showCold)
                            Column(
                                children: [
                                    TweenAnimationBuilder<double>(
                                        tween: Tween(begin: -0.1, end: 0.1),
                                        duration: const Duration(milliseconds: 500),
                                        builder: (context, value, child) {
                                            return Transform.rotate(
                                                angle: value,
                                                child: child,
                                            );
                                        },
                                        onEnd: () {
                                            setState(() {}); // repeat animation
                                        },
                                        child: const Icon(Icons.ac_unit, color: Colors.blue, size: 64),
                                    ),
                                    Text(_message!, style: const TextStyle(fontSize: 20, color: Colors.blue)),
                                ],
                            ),
                    ],
                ),
            ),
        );
    }
}
