// import 'package:get/state_manager.dart';
// import 'package:interview_axolon/model/api_model.dart';

// import '../../services/remote_services.dart';


// class PostController extends GetxController {
//   var isLoading = true.obs;
//   var productList = <Post>[].obs;

//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }

//   void fetchProducts() async {
//     try {
//       isLoading(true);
//       var products = await RemoteService.getPosts();
//       if (products != null) {
//         productList.value = products;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }
