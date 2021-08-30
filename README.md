# Blog/Article GraphQl, express,mongodb

Test queries and mutations

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
 
