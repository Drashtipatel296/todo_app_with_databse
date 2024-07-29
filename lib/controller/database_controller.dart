import 'package:get/get.dart';
import '../helper/database_helper.dart';
import '../model/database_model.dart';

class TaskController extends GetxController {
  var tasks = <Todo>[].obs;
  final DBHelper dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    tasks.value = await dbHelper.fetch();
  }

  void addData(Todo task) async {
    await dbHelper.insert(task);
    fetchData();
  }

  void updateData(Todo task) async {
    await dbHelper.update(task);
    fetchData();
  }

  void deleteData(int id) async {
    await dbHelper.delete(id);
    fetchData();
  }
}