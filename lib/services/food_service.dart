
import 'dart:io';
import 'package:http/http.dart' as http;


class FoodService {

  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse('URL_DEL_SERVIDOR');
    
    // Crea un objeto FormData
    final formData = http.MultipartRequest('POST', url);
    
    // Agrega la imagen al formulario
    formData.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    
    // Envía la solicitud al servidor
    final response = await formData.send();
    
    // Lee la respuesta del servidor
    final String responseString = await response.stream.bytesToString();
    
    // Aquí puedes realizar alguna acción con la respuesta del servidor
  } 

}