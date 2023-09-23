import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Consumer
      body: Consumer<Counter>(
        builder: (BuildContext context, Counter counter, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  // taking the value of _counter variable from the Counter class.
                  '${counter._counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PlusOrMinusButton(
                      color: Colors.cyanAccent,
                      iconButton: IconButton(
                          onPressed: () {
                            // calling the increaseCount method from the Counter class to add the counter by 1.
                            counter.increaseCount();
                          },
                          icon: const Icon(Icons.add)),
                    ),
                    PlusOrMinusButton(
                        iconButton: IconButton(
                            onPressed: () {
                              // calling the decreaseCount method from the Counter class to subtract the counter by 1.
                              counter.decreaseCount();
                            },
                            icon: const Icon(Icons.remove)),
                        color: Colors.deepOrangeAccent)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

//here we have created a new Widget for both the buttons that we are interacting on the UI screen from which we are increasing or decreasing the counter value.
class PlusOrMinusButton extends StatelessWidget {
  const PlusOrMinusButton({
    super.key,
    required this.iconButton,
    required this.color,
  });

  final IconButton iconButton;
  final MaterialAccentColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(100)),
        child: iconButton);
  }
}

class Counter extends ChangeNotifier {
  int _counter = 0;

  //this method is interacting with the onPressed button and increasing the value of _counter by 1, and notifyListener is helping to call all the placed listener in the UI, which is in the text.
  void increaseCount() {
    _counter++;
    notifyListeners();
  }

// this method will decrement the counter number by 1 on pressing the minus button on the screen
  void decreaseCount() {
    _counter--;
    notifyListeners();
  }
}
