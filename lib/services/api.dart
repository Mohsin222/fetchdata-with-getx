import 'package:dio/dio.dart';
import 'package:workwithgetx/model/todo_mdel.dart';
class Constant{
 static String  baseurl ="https://jsonplaceholder.typicode.com/todos/";
}
class ApiClass{


  Future getData({int? from})async{
     final dio = Dio();
    
try {
    final response = await dio.get(Constant.baseurl);
  // print(response.data);
  List<TodoModel> todoList =[];
if(response.statusCode ==200){
  for (var element in response.data) {

    todoList.add(TodoModel.fromJson(element));
  }


  return todoList;
}


} catch (e) {
  print(e.toString());
}
  }
}