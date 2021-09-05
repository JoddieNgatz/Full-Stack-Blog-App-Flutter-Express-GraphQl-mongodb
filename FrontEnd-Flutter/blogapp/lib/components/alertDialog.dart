import 'package:blogapp/services/blog.dart';
import 'package:blogapp/services/graphQLConfig.dart';
import "package:flutter/material.dart";
// ignore: import_of_legacy_library_into_null_safe
import "package:graphql_flutter/graphql_flutter.dart";

class AlertDialogWindow extends StatefulWidget {
   Blog blog;
   bool isAdd;

  AlertDialogWindow({Key? key, required this.blog,  required this.isAdd})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AlertDialogWindow(this.blog, this.isAdd);
}

class _AlertDialogWindow extends State<AlertDialogWindow> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtTopic = TextEditingController();
  TextEditingController txtArticle = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtAuthorID = TextEditingController();
  TextEditingController txtAuthorName = TextEditingController();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

   Blog blog;
   bool isAdd;

  _AlertDialogWindow(this.blog, this.isAdd);

  @override
  void initState() {
    super.initState();
    if (!this.isAdd) {
      TextEditingController txtId = TextEditingController();
      TextEditingController txtName = TextEditingController();
      TextEditingController txtTopic = TextEditingController();
      TextEditingController txtArticle = TextEditingController();
      TextEditingController txtDate = TextEditingController();
      TextEditingController txtAuthorID = TextEditingController();

      txtId.text = blog.getId();
      txtName.text = blog.getName();
      txtTopic.text = blog.getTopic();
      txtArticle.text = blog.getArticle();
      txtDate.text = blog.getDate().toString();
      txtAuthorID.text = blog.getAuhorId();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(this.isAdd ? "Add" : "Edit or Delete"),
      content: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: TextField(
                    maxLength: 5,
                    controller: txtId,
                    enabled: this.isAdd,
                    decoration: InputDecoration(
                      icon: Icon(Icons.perm_identity),
                      labelText: "Article ID",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtAuthorID,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_format),
                      labelText: "AuthorID: ",
                    ),
                  ),
                ),                
                Container(
                  padding: EdgeInsets.only(top: 80.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtAuthorName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_format),
                      labelText: "Author:",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 160.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtName,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_rotate_vertical),
                      labelText: "Name",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 240.0),
                  child: TextField(
                    maxLength: 2,
                    controller: txtDate,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Date:", icon: Icon(Icons.calendar_today)),
                  ),
                ),

                 Container(
                  padding: EdgeInsets.only(top: 160.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtTopic,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_rotate_vertical),
                      labelText: "Topic ",
                    ),
                  ),
                ),

                 Container(
                  padding: EdgeInsets.only(top: 160.0),
                  child: TextField(
                    maxLength: 40,
                    controller: txtArticle,
                    decoration: InputDecoration(
                      icon: Icon(Icons.text_rotate_vertical),
                      labelText: "Article:",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Close"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // !this.isAdd
        //     ? ElevatedButton(
        //         child: Text("Delete"),
        //         onPressed: () async {
        //           GraphQLClient _client = graphQLConfiguration.clientToQuery();
        //           QueryResult result = await _client.mutate(
        //             MutationOptions(
        //               document: addMutation.deleteArticle(txtId.text),
        //             ),
        //           );
        //           if (!result.hasErrors) Navigator.of(context).pop();
        //         },
        //       )
        //     : null,
        ElevatedButton(
          child: Text(this.isAdd ? "Add" : "Edit"),
          onPressed: () async {
            if (txtId.text.isNotEmpty &&
                txtName.text.isNotEmpty &&
                txtTopic.text.isNotEmpty &&
                txtArticle.text.isNotEmpty &&
                txtDate.text.isNotEmpty) {
              if (this.isAdd) {
                GraphQLClient _client = graphQLConfiguration.clientToQuery();
                QueryResult result = await _client.mutate(
                  MutationOptions(
                    document: addMutation.addArticle(
                      txtId.text,
                      txtName.text,
                      txtTopic.text,
                      txtArticle.text,
                      txtDate.text,
                      txtAuthorID.text,
                      txtAuthorName.text,
                    ),
                  ),
                );
                if (!result.hasErrors) {
                  txtId.clear();
                  txtName.clear();
                  txtTopic.clear();
                  txtArticle.clear();
                  Navigator.of(context).pop();
                }
              } else {
                GraphQLClient _client = graphQLConfiguration.clientToQuery();
                QueryResult result = await _client.mutate(
                  MutationOptions(
                    document: addMutation.editArticle(
                      txtId.text,
                      txtName.text,
                      txtTopic.text,
                      txtArticle.text,
                      txtDate.text,
                      txtAuthorID.text,
                      txtAuthorName.text,
                    ),
                  ),
                );
                if (!result.hasErrors) {
                  txtId.clear();
                  txtName.clear();
                  txtTopic.clear();
                  txtArticle.clear();
                  Navigator.of(context).pop();
                }
              }
            }
          },
        )
      ],
    );
  }
}
