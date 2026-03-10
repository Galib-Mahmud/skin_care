import 'package:get/get.dart';
import 'package:skincare/feature/chat_bot/models/chat_history_model.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';
import '../models/reading_model.dart';

class ResourcesController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading = false.obs;
  final Rx<ReadingModel?> recommendedReading = Rx<ReadingModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadReading();
  }

  Future<void> loadReading() async {
    isLoading.value = true;

    try {
      final response = await _apiClient.get(
        ApiEndpoint.aiRecommendedReading,
        requiresAuth: true,
      );

      if (response != null && response['data'] != null) {
        recommendedReading.value =
            ReadingModel.fromJson(response['data']);
      }
    } catch (e) {
      print("Error loading AI recommended reading: $e");
    } finally {
      isLoading.value = false;
    }
  }


}