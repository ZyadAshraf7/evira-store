const _webAPIToken = "AIzaSyB8RAvAvBv5qYJ0wCcMnlO5nDuozZZT-bw";
class APIs{
  static const createUserAPI = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_webAPIToken";
  static const loginUserAPI = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_webAPIToken";
  static const getUserDataAPI = "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$_webAPIToken";
  static const changePasswordAPI = "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$_webAPIToken";
  static const getAllProductsWithLimit = "https://fakestoreapi.com/products?limit=20";
  static const getCategoryProducts = "https://fakestoreapi.com/products/category/";
  static const searchProducts = "https://dummyjson.com/products/search?q=";

  // --------------- PAYMENTS APIS
  static const paymentBaeUrl = "https://accept.paymob.com/api";
  static const getPaymentAuthToken = "/auth/tokens";
  static const paymentApiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RnNU56ZzJMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuUDh1YzQyMVFEdTY2UzMyTW9lSTR6RjFKYnM0d2w2TktJNEFsSUxxU2dINXBOdkwwNnpiYTB4ZXA1ZHFIQ09YLTlTNVhDdkt4bVZKMzdLdHlEQVllYWc=";
  static const getPaymentOrderId = "/ecommerce/orders";

}