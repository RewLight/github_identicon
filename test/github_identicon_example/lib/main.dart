import 'dart:math';

import 'package:flutter/material.dart';
import 'github_identicon.dart';

void main() {
  runApp(const GitHubAvatarApp());
}

class GitHubAvatarApp extends StatelessWidget {
  const GitHubAvatarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Identicon Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Inter',
      ),
      home: const GitHubAvatarPage(),
    );
  }
}

class GitHubAvatarPage extends StatefulWidget {
  const GitHubAvatarPage({super.key});

  @override
  State<GitHubAvatarPage> createState() => _GitHubAvatarPageState();
}

class _GitHubAvatarPageState extends State<GitHubAvatarPage> {
  final TextEditingController _textController = TextEditingController();
  String _seed = 'octocat';
  double _size = 200;
  bool _showGrid = true;

  @override
  void initState() {
    super.initState();
    _textController.text = _seed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Identicons Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GitHubIdenticon(
                    seed: _seed,
                    size: _size,
                    showGrid: _showGrid,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 控制面板
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Panel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Seed',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            setState(() {
                              _seed =
                                  _textController.text.isNotEmpty
                                      ? _textController.text
                                      : 'github';
                            });
                          },
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _seed = value.isNotEmpty ? value : 'github';
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Icon(Icons.aspect_ratio, color: Colors.blue),
                        const SizedBox(width: 10),
                        const Text('大小:'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Slider(
                            value: _size,
                            min: 64,
                            max: 512,
                            divisions: 7,
                            label: '${_size.round()}px',
                            onChanged: (value) {
                              setState(() {
                                _size = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          value: _showGrid,
                          onChanged: (value) {
                            setState(() {
                              _showGrid = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text('Show Grids'),
                      ],
                    ),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _seed =
                                _textController.text.isNotEmpty
                                    ? _textController.text
                                    : 'GithubIdenticon';
                          });
                        },
                        icon: const Icon(Icons.palette),
                        label: const Text('Generate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildExamplesSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandom,
        tooltip: 'Go random',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildExamplesSection() {
    final examples = [
      'octocat',
      'flutter',
      'dart',
      'github',
      'developer',
      'programmer',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Example',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: examples.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: GitHubIdenticon(
                      seed: examples[index],
                      size: 60,
                      showGrid: _showGrid,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(examples[index], style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _generateRandom() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final randomString = List.generate(
      8,
      (index) => chars[random.nextInt(chars.length)],
    ).join('');
    _textController.text = randomString;
    setState(() {
      _seed = randomString;
    });
  }
}
