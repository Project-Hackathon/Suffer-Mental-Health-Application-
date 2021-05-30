import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Blog {
  final String id;
  final String desc;
  final String header;
  final String data;
  final String owner;

  Blog(
      {@required this.id,
      @required this.desc,
      @required this.header,
      @required this.data,
      @required this.owner});
}

class Blogs with ChangeNotifier {
  List<Blog> _blogs = [];
  Blogs(this._blogs);
  List<Blog> get blogs {
    return [..._blogs];
  }

  Future<void> fetchAndSetBlogs() async {
    final url =
        Uri.parse('https://suffer-mental-health-app.herokuapp.com/blogapiurl');
    final response = await http.get(url);
    final List<Blog> loadedBlogs = [];
    final extractedData = json.decode(response.body) as List;
    if (extractedData == null) {
      return;
    }
    print(extractedData);
    extractedData.forEach((blogData) {
      loadedBlogs.add(Blog(
          id: blogData['id'].toString(),
          desc: blogData['short'],
          header: blogData['header'],
          data: blogData['data'],
          owner: blogData['owner']));
    });
    _blogs = loadedBlogs.reversed.toList();
    notifyListeners();
  }
}
