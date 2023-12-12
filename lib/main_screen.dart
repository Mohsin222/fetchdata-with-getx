import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:smartrefresh/smartrefresh.dart';
import 'package:workwithgetx/controllar1.dart';
import 'package:workwithgetx/model/todo_mdel.dart';
import 'package:workwithgetx/services/api.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<TodoModel> todoList=[];
  @override
  Widget build(BuildContext context) {
     final contrll = Get.put(Controller1());
    return  Scaffold(
      appBar: AppBar(
        title: Text(contrll.loading.value.toString()),
        actions: [
          
          IconButton(onPressed: (
            
          )async{
contrll.refreshData();
          }, icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        //  ApiClass apiClass =ApiClass();

//  var d= await   contrll.getData();

//  todoList.addAll(d);
// print(d);
await   contrll.getData();
//  setState(() {
   
//  });
      }),
      // body: Obx(
      //           (){
      //                  return ListView.builder(
      //       itemCount: contrll.todoList.length,
      //       itemBuilder: (context,index){
      //      if(contrll.loading.value ==true ){
      //       // return Center(child: CircularProgressIndicator(color: Colors.red,),);
      //       return Center(child: Text('aaaaaaaaaaaaa'),);
      //      }else{
      //       print(contrll.todoList.length);
      //        return Text(contrll.todoList[index].title.toString());
      //      }
      
      //     });
      //           } 
      // ),

      body :PullToRefresh(
        
refreshController:contrll.refreshController ,
        onRefresh: (){contrll.refreshData();},
        onComplete: completeindicator(),
        onFail: Center(child: Text('FAIL'),),
        onLoading: loadingindicator(),
        child: ListBuilder()
        
      )
    );
  }
 completeindicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.done,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Refresh Completed',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'))
      ],
    );
  }
    loadingindicator() {
    return const Text('Refreshing..',
        style: TextStyle(
            color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'));
  }

 failedIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.close,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Failed',
            style: TextStyle(
                color: Colors.grey, fontFamily: 'SourceSansPro-SemiBold'))
      ],
    );
  }
  
}

class ListBuilder extends StatelessWidget {
  const ListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller1>(
        builder: (controller) {
    return      controller.isLoading ==true? 
    Center(child: CircularProgressIndicator()):
            ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context,index){
          
            print(controller.todoList.length);
             return Text(controller.todoList[index].title.toString());
           
      
          });
        },

      );
  }
}