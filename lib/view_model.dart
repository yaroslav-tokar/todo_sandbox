import 'package:todo_sandbox/stateful_model/base_model.dart';

class HomeModel extends BaseModel {
  void makeRequest() async {
    onBusyProgressViewStateEvent();
    await Future.delayed(Duration(milliseconds: 1500));
    onIdleProgressViewStateEvent();
  }

  void dispose() {
    super.dispose();
  }
}
