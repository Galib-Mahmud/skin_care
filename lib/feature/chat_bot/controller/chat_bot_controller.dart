import 'package:get/get.dart';
import 'package:skincare/feature/chat_bot/models/chat_history_model.dart';
import '../../../core/endpoint/api_client.dart';
import '../../../core/endpoint/api_endpoint.dart';
import '../../../routes/route_name.dart';

class ChatBotController extends GetxController {
  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  final RxBool isLoading = false.obs;
  final RxBool isGeneratingResponse = false.obs;
  final RxString botType = 'skincare'.obs;
  final RxList<ChatHistoryModel> chatHistory = <ChatHistoryModel>[].obs;

  Future<String?> sendMassage(String massage) async {
    isGeneratingResponse.value = true;
    try {
      final response = await _apiClient.post(
        ApiEndpoint.aiChatbot,
        body: {
          "message": massage,
          "bot_type": botType.value,
          "session_id": 0
        },
        requiresAuth: true,
      );

      if (response != null && response.isNotEmpty) {
        final botReply = response['response'];
        return botReply;
      }
    } catch (e) {
      print('❌ Failed to send message: $e');
      return null;
    } finally {
      isGeneratingResponse.value = false;
    }
    return null;
  }

  Future<void> loadHistory() async {
    isLoading.value = true;

    print("🔍 Loading chat history for bot type: ${botType.value}");

    try {
      final response = await _apiClient.get(
        "${ApiEndpoint.chatSessions}?bot_type=${botType.value}",
        requiresAuth: true,
      );

      if (response != null && response.isNotEmpty) {
        final messages = response[0]['messages'];

        chatHistory.value =
            (messages as List).map((e) => ChatHistoryModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('❌ Failed to load chat history: $e');
    } finally {
      isLoading.value = false;
    }
  }


}