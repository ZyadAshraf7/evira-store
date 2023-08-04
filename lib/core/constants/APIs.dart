const _webAPIToken = "AIzaSyB8RAvAvBv5qYJ0wCcMnlO5nDuozZZT-bw";
class APIs{
  static const createUserAPI = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_webAPIToken";
  static const loginUserAPI = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_webAPIToken";
  static const getUserDataAPI = "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$_webAPIToken";
  static const changePasswordAPI = "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$_webAPIToken";
  static const getAllProductsWithLimit = "https://fakestoreapi.com/products?limit=20";
  static const getCategoryProducts = "https://fakestoreapi.com/products/category/";
  static const searchProducts = "https://dummyjson.com/products/search?q=";

}