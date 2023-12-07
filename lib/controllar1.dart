import 'package:get/get.dart';
import 'package:smartrefresh/smartrefresh.dart';
import 'package:workwithgetx/model/todo_mdel.dart';
import 'package:workwithgetx/services/api.dart';

class Controller1 extends GetxController {
final RefreshController refreshController = RefreshController();
var loading =false.obs;
bool _isLoading =false;

bool get isLoading => _isLoading;
void setLoading(bool load){
  _isLoading=load;
  update();
}
  List<TodoModel> todoList=<TodoModel> [].obs;
  getData()async{

  //  loading(true);
  setLoading(true);
  print(loading);
    ApiClass apiClass =ApiClass();
    apiClass.getData().then((value)  {
      todoList.assignAll(value);

    //  loading(false);
      setLoading(false);
    })
    .whenComplete(() {
      refreshController.refreshCompleted();
setLoading(false);

    })
    .catchError((err)=>{

      print("Controller 1 error "+err)
    });

    
   
  }


  refreshData()async{
      
    todoList.clear();
     
     

    await  getData();

  }
}