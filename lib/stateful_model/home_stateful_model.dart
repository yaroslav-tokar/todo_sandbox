import 'package:todo_sandbox/stateful_model/base_stateful_model.dart';

class HomeStatefulModel extends BaseStatefulModel {
  void faceRequest() async {
    onBusy();
    await Future.delayed(Duration(milliseconds: 1500));
    onIdle();
  }

  void fetchNotes() async {

  }
}
