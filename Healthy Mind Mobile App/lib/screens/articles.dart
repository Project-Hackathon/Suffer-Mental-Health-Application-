import 'package:flutter/material.dart';
import 'package:healthy_mind/providers/blogs.dart' show Blogs;
import 'package:provider/provider.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Provider.of<Blogs>(context, listen: false).fetchAndSetBlogs(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(child: Text('An Error Occured'));
          } else {
            return Consumer<Blogs>(
              builder: (ctx, blogData, child) => ListView.builder(
                  itemCount: blogData.blogs.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  blogData.blogs[i].header,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'By ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      blogData.blogs[i].owner,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  blogData.blogs[i].desc,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MaterialButton(
                                            child: Text(
                                              'Read Full Article',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            height: 50,
                                            minWidth: 150,
                                            splashColor:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {},
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
