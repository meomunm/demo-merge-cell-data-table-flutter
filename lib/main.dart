import 'package:demo_merge_data_table/widget_demo_merge.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SyncListView(),
    );
  }
}

class SyncListView extends StatefulWidget {
  const SyncListView({super.key});

  @override
  _SyncListViewState createState() => _SyncListViewState();
}

class _SyncListViewState extends State<SyncListView> {
  final Map<int, double> itemHeights = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Synchronized Lists with RenderObject')),
      body: CustomerLastTransactionTableWidget(data: testCustomerData),
    );
  }
}