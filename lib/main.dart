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
                    // taking the value of _counter variable from the Counter page.
                    '${counter._counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                              onPressed: () {
                                counter.increaseCount();
                              },
                              icon: const Icon(Icons.add))),
                      Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                              onPressed: () {
                                counter.decreaseCount();
                              },
                              icon: const Icon(Icons.remove))),
                    ],
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: Consumer<Counter>(
          builder: (BuildContext context, Counter value, Widget? child) {
            return FloatingActionButton(
              onPressed: () {
                // calling the increaseCount method from Counter page.
                value.increaseCount();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          },
        ));
  }
}

class Counter extends ChangeNotifier {
  int _counter = 0;

  //this method is interacting with the onPressed button and increasing the value of _counter by 1, and notifyListener is helping to call all the placed listener in the UI, which is in the text.
  void increaseCount() {
    _counter++;
    notifyListeners();
  }

  void decreaseCount() {
    _counter--;
    notifyListeners();
  }
}
