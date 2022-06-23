import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:interview_axolon/main.dart';
import 'package:interview_axolon/view/constants/colors.dart';

import '../model/api_model.dart';
import '../services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;

  var isLoaded = false;

@override
  void initState() {
    
    super.initState();

    // feth data from api
    getData();
  }

  getData()async{
    posts = await RemoteService().getPosts();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonScaffoldBack,
      appBar: AppBar(
        backgroundColor: splashBackColor,
        automaticallyImplyLeading: false,
        title: const Text('Posts From Api', style: TextStyle(fontFamily: 'Rubik'),),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Get.toNamed('/account');
             }
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed('/login');
              preferences!.setBool('isLogin', false);
             }
          )
        ]
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                
                children: [
                  Container(height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    image: DecorationImage(image: NetworkImage(posts![index].url),)
                  ),
                  ),
                 const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(posts![index].title, style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),),
                        // Text(posts![index].body!, style: TextStyle(
                        //   fontSize: 18,
                        //   fontWeight: FontWeight.w400,
                        // ),),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
          replacement: const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}