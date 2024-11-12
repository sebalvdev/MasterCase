import 'package:http/http.dart' as http;

class Utilities {
  Future<String> fetchLoremIpsum(int paragraphs) async {
    // Construye la URL con el parámetro de párrafos
    final String apiUrl =
        'https://api.api-ninjas.com/v1/loremipsum?paragraphs=$paragraphs';

    try {
      // Realiza la solicitud GET con los encabezados
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'X-Api-Key': 'YOUR_API_KEY', // Coloca aquí tu API Key
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Devuelve el texto de la respuesta en caso de éxito
        return response.body;
      } else {
        // Devuelve un mensaje de error si la solicitud falla
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      // Manejo de errores en caso de fallo de conexión u otro tipo de error
      return 'Error: $e';
    }
  }
}
