import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//GET method
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _postJson = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    fetchData();
  }

  void fetchData() async {
    final url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      // await get(Uri.parse(url)).then((response) {
      //   final jsonData = (jsonDecode(response.body)) as List;

      // });
      final response = await get(Uri.parse(url));
      final jsonData = (jsonDecode(response.body)) as List;
      setState(() {
        _postJson = jsonData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final post = _postJson[index];
          return ListTile(
            title: Text(post['title']),
            subtitle: Text(post['body']),
            iconColor: Colors.blue,
            leading: Icon(Icons.abc),
            autofocus: true,
            contentPadding: const EdgeInsets.all(8),
            dense: true,
            enableFeedback: true,
            enabled: true,
            focusColor: Colors.black45,
            horizontalTitleGap: 8,
            isThreeLine: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.black45,
                width: 0.1,
              ),
            ),
            mouseCursor: MaterialStateMouseCursor.clickable,
            selected: false,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PostPage()));
            },
          );
        },
        itemCount: _postJson.length,
      ),
    );
  }
}

//POST method

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

void postData() async {
  final url = 'https://jsonplaceholder.typicode.com/posts';
  try {
    final response = await post(Uri.parse(url), body: {
      'title': 'Dart',
      'body': 'Dart is a programming language',
      'userId': '1'
    });
    print(response.body);
  } catch (e) {
    print(e);
  }
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            postData();
          },
          child: Text('POST'),
        ),
      ),
    );
  }
}
