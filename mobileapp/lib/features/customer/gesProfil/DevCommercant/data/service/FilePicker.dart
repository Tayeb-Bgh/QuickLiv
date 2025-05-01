import 'package:file_picker/file_picker.dart';

class Filepicker {
    Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}