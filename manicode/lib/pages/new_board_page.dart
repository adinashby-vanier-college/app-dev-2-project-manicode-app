import 'package:flutter/material.dart';

class NewBoardPage extends StatelessWidget {
  const NewBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('+ New Board')),
      body: const Center(child: Text('This is the New Board Page')),
    );
  }
}