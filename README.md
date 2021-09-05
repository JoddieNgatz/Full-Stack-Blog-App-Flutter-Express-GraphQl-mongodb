# Blog/Article GraphQl, express,mongodb

Blog GraphQL
Make things easier for your teammates with a complete collection description.
POST
Query article
http://localhost:8080/graphql/
Make things easier for your teammates with a complete request description.
Request Headers
Accept
application/json
Bodygraphql
QUERY
graphql
mutation{
  addAuthor(name:"Joseph Mureithi",url:"https://localhost",major:"Software Engineering"){
    name
    id
    url
    major
  },
  addArticle(name:"intro to graphQl", topic:"Software Engineering", date:"Today",authorId:"123"){
    name
    topic
    date
    id
    authorId
  }
},
Example
Mutation add article
Request
JavaScript - Fetch
var myHeaders = new Headers();
myHeaders.append("Accept", "application/json");
myHeaders.append("Content-Type", "application/json");

var graphql = JSON.stringify({
  query: "",
  variables: {}
})
var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: graphql,
  redirect: 'follow'
};

fetch("http://localhost:8080/graphql/", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
Response
json
{
  "data": {
    "addAuthor": {
      "name": "Joseph Mureithi",
      "id": "612e5908dca0d571959121d7",
      "url": "https://localhost",
      "major": "Software Engineering"
    },
    "addArticle": {
      "name": "intro to graphQl",
      "topic": "Software Engineering",
      "article":"This is a test article"
      "date": "Today",
      "id": "612e5909dca0d571959121d9",
      "authorId": "123"
    }
  }
}
GET
Query article
http://localhost:8080/graphql/
Make things easier for your teammates with a complete request description.
Request Headers
Accept
application/json
Bodygraphql
QUERY
graphql
{
  article(id:"612d5ab6dca0d571959121d3"){
    name
    topic
    date
    author{
      name
      major
    }
  }
}
Example
Query article
Request
JavaScript - Fetch
var myHeaders = new Headers();
myHeaders.append("Accept", "application/json");
myHeaders.append("Content-Type", "application/json");
 
var graphql = JSON.stringify({
  query: "",
  variables: {}
})
var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  body: graphql,
  redirect: 'follow'
};
 
fetch("http://localhost:8080/graphql/", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
Click to Expand
Response
json
{
  "data": {
    "article": {
      "name": "intro to graphQl",
      "topic": "Software Engineering",
      "date": "Today",
      "author": null
    }
  }
}