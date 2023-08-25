import 'package:http/http.dart' as http;
class GetProductFromLocalHost{
  
  static Future<void>fetchMyData()async{
    final response = await http.get(Uri.parse("https://1468-102-188-85-200.ngrok-free.app/products/clothes"));
    print(response.body);
  }
}