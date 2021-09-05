class Blog {
  Blog(this.id, this.name, this.topic, this.article, this.date, this.authorId,
      this.authorName);

  final String id;
  final String name;
  final String topic;
  final String article;
  final String date;
  final String authorId;
  final String authorName;

  getId() => this.id;
  getName() => this.name;
  getTopic() => this.topic;
  getArticle() => this.article;
  getDate() => this.date;
  getAuhorId() => this.authorId;
  getAuthorName() => this.authorName;
}

class QueryMutation {
  String addArticle(String id, String name, String topic, String article,
      String date, String authorId, String authorName) {
    return """
      mutation{
        addArticle(id:"$id", name:"$name", topic:"$topic", article:"$article", date: "$date", authorId:"$authorId",authorName:"$authorName"){

          name
          topic
          article
          date
          id
          authorId
          authorName

        }
      }""";
  }

    String getAllArticles() {
    return """
    {
        Article{

          name
          topic
          article
          date
          id
          authorId
          authorName

        }
      }""";
  }


    String editArticle(String id, String name, String topic, String article,
      String date, String authorId, String authorName) {
        //need to do this on backend
    return """
      mutation{
        editArticle(id:"$id", name:"$name", topic:"$topic", article:"$article", date: "$date", authorId:"$authorId",authorName:"$authorName"){

          name
          topic
          date
          article

        }
      }""";
  }

  String addAuthor(String id, String name, String url, String major) {
    return """
      mutation{
        addAuthor(id:"$id", name:"$name", url:"$url", url:"$url"){

          name
          id
          url
          major
          

        }
      }""";
  }

  String getAuthors(String id, String name, String url, String major) {
    return """
    {
        author{

          name
          id
          url
          major

        }
      }""";
  }

  String getAuthorByName(String authorName) {
    return """
    {
        author(name:"$authorName"){

          name
          id
          url
          major

        }
      }""";
  }

  //get articles by author name

  String getArticle(String id, String name, String topic, String article,
      String date, String authorId) {
    return """
    {
        Article{

          name
          topic
          article
          date
          id
          authorId

        }
      }""";
  }

  String deleteAuthor(id) {
    return """
      mutation{
        deleteAuthor(id: "$id"){
          id
        }
      } 
    """;
  }

  String deleteArticle(id) {
    return """
      mutation{
        deleteArticle(id: "$id"){
          id
        }
      } 
    """;
  }
}
