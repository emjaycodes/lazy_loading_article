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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ItemsList(),
    );
  }
}

class ItemsList extends StatefulWidget {
  ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
   List<String> items =[];
  final ScrollController _scrollController = ScrollController();
  int currentMax = 10;

  @override
  void initState() {
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    
  }

 

  /// Load initial data here
  void loadData() async {
    await Future.delayed(const Duration(seconds: 2)); 
     items = List.generate(11, (index) =>  "items : $index");
  }
  
 void _loadMoreData() async{
    print('show more');
    await Future.delayed(const Duration(seconds: 4)); 
    List<String> moreData;
    moreData = List.generate(10, (index) =>  "items : ${currentMax + index + 1}");
    items.addAll(moreData);
    currentMax += 10;
    print(_scrollController.position.toString());
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Item List")),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 80,
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return const Center(child: CircularProgressIndicator());
          }
          return Card(
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}
