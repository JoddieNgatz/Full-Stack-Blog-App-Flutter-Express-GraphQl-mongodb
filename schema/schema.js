const { query } = require('express');
const graphql = require('graphql');
const { GraphQLObjectType, GraphQLString, GraphQLID, GraphQLList, GraphQLSchema, GraphQLNonNull } = graphql;
const articles = require('../model/articles.model');
const authors = require('../model/authors.model');

  
const ArticleType = new GraphQLObjectType({
    name: 'Article',
    fields: () => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        topic: { type: GraphQLString },
        date: { type: GraphQLString },
        authorId: { type: GraphQLID },
        author:{
            type: authorType,
            resolve(parent,args){
                return authors.findById(args.id);
            }
        }
    })
});

const authorType = new GraphQLObjectType({
    name: 'author',
    fields: ( ) => ({
        id: { type: GraphQLID },
        name: { type: GraphQLString },
        url: { type: GraphQLString },
        major: { type: GraphQLString },
        articles:{
            type: new GraphQLList(ArticleType),
            resolve(parent,args){
                return article.find({authorId:parent.id})
            }
        }
    })
});

//route Query
const RootQuery = new GraphQLObjectType({
    name: 'RootQueryType',
    fields: {
        status: {
            type: GraphQLString,
            resolve(parent, args) {
                return "Welcome to GraphQL"
            }
        },
        article: {
            type: ArticleType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return articles.findById(args.id)
            }
        },
        author: {
            type: authorType,
            args: { id: { type: GraphQLID } },
            resolve(parent, args) {
                return authors.findById(parent.authorId)
            }
        }
    }
});


//route Query
const RootMutation = new GraphQLObjectType({
    name: 'RootMutationType',
    fields: {
        addArticle: {
            type: ArticleType,
            args: {
                name: { type: new GraphQlNonNull(GraphQLString) },
                topic: { type: new GraphQlNonNull(GraphQLString) },
                date: { type: new GraphQlNonNull(GraphQLString) },
                authorId: { type: GraphQlNonNull(GraphQLID) }, },
            resolve(parent, args) {
                let articl = new articles({
                    name: args.name,
                    topic: args.topic,
                    date: args.date,
                    authorId: args.authorId
                })
                return articl.save();
            }
        },
        addAuthor: {
            type: authorType,
            args: {       
            name: { type: new GraphQlNonNull(GraphQLString )},
            url: { type: new GraphQlNonNull(GraphQLString) },
            major: { type: new GraphQlNonNull(GraphQLString) }, },
            resolve(parent, args) {
                let authr = authors({
                    name: args.name,
                    url: args.url,
                    major: args.major
                });
                return authr.save();
            }
        }
    }
});

module.exports = new GraphQLSchema({
    //The GraphQLSchema takes an object with key-value pairs. One key is query. To this key, pass the above created RootQuery as a value. 
    query: RootQuery,
    mutation: RootMutation
});