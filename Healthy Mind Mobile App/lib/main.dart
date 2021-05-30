import 'package:flutter/material.dart';
import 'package:healthy_mind/providers/auth.dart';
import 'package:healthy_mind/providers/blogs.dart';
import 'package:healthy_mind/screens/chatbot.dart';
import 'package:healthy_mind/screens/login.dart';
import 'package:healthy_mind/tabbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Blogs>(
              update: (ctx, auth, previousBlogs) =>
                  Blogs(previousBlogs == null ? [] : previousBlogs.blogs))
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                title: 'Healthy Mind',
                theme: ThemeData(
                  primaryColor: Color(0xff5370E0),
                ),
                debugShowCheckedModeBanner: false,
                home: Tabbar()

                // home: Register(),
                )));
  }
}
