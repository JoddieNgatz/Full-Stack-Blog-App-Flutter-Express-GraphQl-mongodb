const express = require('express');
const app = express();
const cors = require('cors');
const mongoose = require('mongoose');
const schema = require('./schema/schema');
const { graphqlHTTP } = require('express-graphql');
require('dotenv').config();
const corsOptions = {
    
    origin: "http://localhost:8081"
}

const db = require('./config/db.config');

console.log(db.url);
console.log("connecting to db");
//mongoose.connect(process.env.url, { useNewUrlParser: true, useUnifiedTopology: true });

mongoose.connect(db.url, { useNewUrlParser: true, useUnifiedTopology: true });
mongoose.connection.once('open', () => {
    console.log("Connected to MongoDB")
});
    // .catch(err => {
    //     console.log('problem connecting to db', err); process.exit;
    // });
    
app.disable('x-powered-by');
app.use(cors(corsOptions));

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use('/graphql', graphqlHTTP({
    schema: schema,
    graphiql:true
}));

app.get('/', (req, res) => {
     res.json({message:'Welcome to GraphQL server. Use GraphQL endpoint at /graphql'});
});



const PORT = process.env.PORT || 8080;


app.listen(PORT, () => {
    console.log(`Server running on port: ${PORT} at http://localhost:${PORT}`);
});