import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 238, 0),
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(title: 'Calculadora Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '0';
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  String _operation = '';
  bool _flag = true;

  void _inputDigit(String digit) {
    setState(() {
      if (_display == '0' || _display == 'Error' || _flag == false) {
        _display = digit;
        _flag = true;
      } else {
        _display += digit;
      }
    });
  }

  void _inputOperation(String operation) {
    setState(() {
      if (_operation.isNotEmpty) {
        _calculate();
      }
      _firstNumber = double.parse(_display);
      _operation = operation;
      _flag = false;
    });
  }

  void _calculate() {
    setState(() {
      if (_operation.isEmpty) {
        return;
      }

      _secondNumber = double.parse(_display);

      double result;
      switch (_operation) {
        case '+':
          result = _firstNumber + _secondNumber;
          break;
        case '-':
          result = _firstNumber - _secondNumber;
          break;
        case '*':
          result = _firstNumber * _secondNumber;
          break;
        case '/':
          if (_secondNumber == 0) {
            _display = 'Error';
            _firstNumber = 0.0;
            _secondNumber = 0.0;
            _operation = '';
            return;
          } else {
            result = _firstNumber / _secondNumber;
          }

          break;
        default:
          result = 0.0;
      }

      _display = result.toStringAsFixed(2);
      _firstNumber = result;
      _secondNumber = 0.0;
      _operation = '';
      _flag = false;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstNumber = 0.0;
      _secondNumber = 0.0;
      _operation = '';
      _flag = true;
    });
  }

  void _percentage() {
    setState(() {
      double result;
      result = double.parse(_display) / 100;
      _display = result.toStringAsFixed(2);
    });
  }

  void _negative() {
    setState(() {
      if (_display[0] == '-' && _display != '0') {
        _display = _display.substring(1);
      } else {
        _display = '-$_display';
      }
    });
  }

  void _coma() {
    setState(() {
      if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  Widget buildButton(String text, void Function() onPressed,
      {double fontSize = 30.0, Size size = const Size(75.0, 75.0)}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(size),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth * 0.9, // 90% of screen width
              height: screenHeight * 0.1, // 10% of screen height
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: Align(
                child: Text(
                  _display,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 40),
              buildButton('C', _clear),
              const Spacer(flex: 1),
              buildButton('+/-', _negative, fontSize: 17.0),
              const Spacer(flex: 1),
              buildButton('%', _percentage),
              const Spacer(flex: 1),
              buildButton('/', () => _inputOperation('/')),
              const SizedBox(width: 40),
            ]),
            const SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 40),
              buildButton('7', () => _inputDigit('7')),
              const Spacer(flex: 1),
              buildButton('8', () => _inputDigit('8')),
              const Spacer(flex: 1),
              buildButton('9', () => _inputDigit('9')),
              const Spacer(flex: 1),
              buildButton('*', () => _inputOperation('*')),
              const SizedBox(width: 40),
            ]),
            const SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 40),
              buildButton('4', () => _inputDigit('4')),
              const Spacer(flex: 1),
              buildButton('5', () => _inputDigit('5')),
              const Spacer(flex: 1),
              buildButton('6', () => _inputDigit('6')),
              const Spacer(flex: 1),
              buildButton('-', () => _inputOperation('-')),
              const SizedBox(width: 40),
            ]),
            const SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 40),
              buildButton('1', () => _inputDigit('1')),
              const Spacer(flex: 1),
              buildButton('2', () => _inputDigit('2')),
              const Spacer(flex: 1),
              buildButton('3', () => _inputDigit('3')),
              const Spacer(flex: 1),
              buildButton('+', () => _inputOperation('+')),
              const SizedBox(width: 40),
            ]),
            const SizedBox(height: 15.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 40),
              buildButton('0', () => _inputDigit('0'),
                  size: const Size(150.0, 75.0)),
              const Spacer(flex: 1),
              buildButton('.', _coma),
              const Spacer(flex: 1),
              buildButton('=', _calculate),
              const SizedBox(width: 40),
            ])
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
