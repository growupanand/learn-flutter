import 'package:flutter/material.dart';
import 'package:sample_flutter/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("this should not print once");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              StreamBuilder(
                  stream: counterBloc.counterStream,
                  builder: (context, snapshot) {
                    print({"streamContext": context});
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  }),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  counterBloc.eventSink.add(CounterAction.Increment);
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  counterBloc.eventSink.add(CounterAction.Decrement);
                },
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  counterBloc.eventSink.add(CounterAction.Reset);
                },
                tooltip: 'Reset',
                child: const Icon(Icons.loop),
              ),
            ],
          ),
        ));
  }
}
