class ApiEndPoints {
  ApiEndPoints._();
  static const _apiBaseUrl = 'http://10.0.2.2:3000/v1/admin';
  static const _rootUrl = 'http://10.0.2.2:3000/';

  // static const _apiBaseUrl = 'https://organicfoods.passivedesk.com/v1/admin';
  // static const _rootUrl = 'https://organicfoods.passivedesk.com/';

// auth api
  static const _login = "$_apiBaseUrl/login";

  static const _getAppInfo = "$_apiBaseUrl/get-app-info";
  static const _getCategories = "$_apiBaseUrl/get-categories";
  static const _createCategory = "$_apiBaseUrl/create-category";
  static const _createProduct = "$_apiBaseUrl/create-product";
  static const _getSliders = "$_apiBaseUrl/get-sliders";
  static const _createSlider = "$_apiBaseUrl/create-slider";
  static const _getDivisions = "$_apiBaseUrl/get-divisions";
  static const _updateOrderStatus = "$_apiBaseUrl/update-order-status";

  static String get rootUrl => _rootUrl;

  static String get login => _login;

  static String get getAppInfo => _getAppInfo;
  static String get getCategories => _getCategories;
  static String get createCategory => _createCategory;
  static String get createProduct => _createProduct;
  static String get getSliders => _getSliders;
  static String get createSlider => _createSlider;
  static String get getDivisions => _getDivisions;
  static String get updateOrderStatus => _updateOrderStatus;

  static String deleteAddress(String id) {
    return "$_apiBaseUrl/delete-address/id=$id";
  }

  static String deleteSlider(String id) {
    return "$_apiBaseUrl/delete-slider/id=$id";
  }

  static String removeFromCart(String productId) {
    return "$_apiBaseUrl/remove-from-cart/productId=$productId";
  }

  static String addToCart(String productId) {
    return "$_apiBaseUrl/add-to-cart/productId=$productId";
  }

  static String searchProducts(String query) {
    return "$_apiBaseUrl/search-products/query=$query";
  }

  static String getProducts({int? skip = 0}) {
    return "$_apiBaseUrl/get-products/skip=$skip";
  }

  static String allOrders({int? skip = 0}) {
    return "$_apiBaseUrl/all-orders/skip=$skip";
  }

  static String productsByCategory(String categoryId, {int? skip = 0}) {
    return "$_apiBaseUrl/products-by-category/categoryId=$categoryId/skip=$skip";
  }
}
