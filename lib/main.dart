import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/default_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DefaultBloc()),
      ],
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController()
      ..text = context.read<DefaultBloc>().state.name
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: context.read<DefaultBloc>().state.name.length));
    return BlocBuilder<DefaultBloc, DefaultState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("bloc value : ${context.read<DefaultBloc>().state.name}"),
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context
                .read<DefaultBloc>()
                .add(OnDefaultUpdated(textController.text)),
            tooltip: 'Increment',
            child: const Icon(Icons.check),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
