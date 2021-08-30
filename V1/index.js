const express = require('express');
const app = express();
const cors = require('cors');

const schema = require('./schema/schema');
const { graphqlHTTP } = require('express-graphql');
const corsOptions = {
    
    origin: "http://localhost:8081"
}

// const db = require('./models/init.models');
// console.log("connecting to db")
//  db.mongoose.connect(db.url, { useNewUrlParser: true, useUnifiedTopology: true }).then(() => {
//         console.log('connected to database');
//     }).catch(err => {
//         console.log('problem connecting to db', err); process.exit;
//     });
    
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