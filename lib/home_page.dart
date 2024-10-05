import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_example/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void listenTodos() async {
    final stream = supabase.from('Todo').stream(primaryKey: ['id']);

    await for (final event in stream) {
      log('$event');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: listenTodos,
            child: const Text('listen'),
          ),
          TextButton(
            onPressed: () async {
              final response = await supabase.from('Todo').insert({
                'description': 'from app',
                'state': 'pending',
                'title': 'gg',
              }).select();
              log("${(response)}", name: "response");
            },
            child: const Text('insert'),
          ),
          TextButton(
            onPressed: () async {
              final response = await supabase
                  .from("Todo")
                  .update({"title": "gg"})
                  .eq("id", 1)
                  .select();
              log("${(response)}", name: "response");
            },
            child: const Text('update'),
          ),
        ],
      ),
    );
  }
}
