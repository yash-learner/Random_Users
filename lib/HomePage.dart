import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List usersData;
  bool isLoading = true;
  final url = "https://randomuser.me/api/?results=50";
  Future getData() async {
    var respone = await http.get(Uri.encodeFull(url),
    headers: {"Accept":"appication/json"}); // header may be authenication token
    
    List data = jsonDecode(respone.body)['results'];
    setState(() {
      usersData = data;
      isLoading =false;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Random Users')
      ),
       body:Container(
         child:Center(
            child: isLoading?CircularProgressIndicator()
            :ListView.builder(
              itemCount: usersData == null?0:usersData.length,
              itemBuilder:(BuildContext context, int index) {
                   return Card(
                     child: Row(
                       children: <Widget>[
                         Container(
                           margin: EdgeInsets.all(20.0),
                           child: Image(
                             width: 70.0,
                             height: 70.0,
                             fit: BoxFit.contain,
                             image: NetworkImage(usersData[index]["picture"]["thumbnail"]
                             ),
                             ),
                         ),
                         Expanded(
                           child:Column(
                             crossAxisAlignment: CrossAxisAlignment.start, //flexbox properties
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Padding(
                                 padding: const EdgeInsets.only(),
                                 child: Text(
                                   usersData[index]['name']['first']+" "+
                                   usersData[index]['name']['last'],
                                  style: TextStyle(fontSize:20.0,fontWeight: FontWeight.bold),
                                   ),
                               ),
                                 Text("Phone: ${usersData[index]['phone']}"),
                                 Text("Gender: ${usersData[index]['gender']}"),
                                 // ctrl +b to remove side bar in vs code
                             ],
                           )
                         
                         )
                       ],
                     ),
                   );
              },
              ),
         ),
       ),
    );
  }
} 