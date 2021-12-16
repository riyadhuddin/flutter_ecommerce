import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
const productsGraphql = """
query products(first: 10) {
    edges {
      node {
        id
        name
        description
        thumbnail{
          url
        }
      }
    }
  }
""";
void main() {
  final HttpLink httplink = HttpLink('https://demo.saleor.io/graphql/');
  
  ValueNotifier<GraphQLClient> client = ValueNotifier(  GraphQLClient(link: httplink,cache: GraphQLCache(store: InMemoryStore()),),);
 var app = GraphQLProvider(client: client, child: MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Query(options: QueryOptions(document: gql(productsGraphql)),
       builder: (QueryResult result, {fetchMore, refetch}){
         if(result.hasException){
           return Text(result.exception.toString());
         }
         if(result.isLoading){
           return Center(child: CircularProgressIndicator(),);
         }
         final productList = result.data?['products']['edges'];
        //  print(productList);
        //  return Text("some");
        return column(
          
        );
       }),
    );
  }
}
