import 'package:blogapp/components/alertDialog.dart';
import 'package:blogapp/services/blog.dart';
import 'package:blogapp/services/graphQLConfig.dart';
import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class Articles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Articles();
}

class _Articles extends State<Articles> {
  // ignore: deprecated_member_use
  List<Blog> listArticles = <Blog>[];
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  void fillList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
      QueryOptions(
        document: queryMutation.getAllArticles(),
      ),
    );
    if (result.data != Null) {
      for (var i = 0; i < result.data["Articles"].length; i++) {
        setState(() {
          listArticles.add(
            Blog(
              result.data["Article"][i]["id"],
              result.data["Article"][i]["name"],
              result.data["Article"][i]["topic"],
              result.data["Article"][i]["article"],
              result.data["Article"][i]["date"],
              result.data["Article"][i]["authorId"],
              result.data["Article"][i]["authorName"],
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }

  void _addArticle(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var results;
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: true, blog: results,);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listArticles.clear();
      fillList();
    });
  }

  void _editDeleteArticle(context, Blog blog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: false, blog: blog);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listArticles.clear();
      fillList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _addArticle(context),
            tooltip: "Insert new Article",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Person",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              itemCount: listArticles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: listArticles == null ? false : true,
                  title: Text(
                    "${listArticles[index].getName()}",
                  ),
                  onTap: () {
                    _editDeleteArticle(context,  listArticles[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}