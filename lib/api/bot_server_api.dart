import 'package:chats_manager/models/bot_server_api/messages_api_models.dart';
import 'package:chats_manager/private_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

part 'bot_server_api.g.dart';

@RestApi(baseUrl: api_bot_server_base_url)
abstract class BotServerApiClient {
  static Future<BotServerApiClient> getClient() async {
    final dio = Dio(); // Provide a dio instance

    dio.options.headers["tkn"] =
        await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";

    if (!Foundation.kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    return _BotServerApiClient(dio);
  }

  @POST("/api/v1/po/send_text_msg")
  Future<SendMessageResponse> sendMessage(
      @Body() SendMessageRequest sendMessageRequest);
}
