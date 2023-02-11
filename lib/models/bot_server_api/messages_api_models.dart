import 'package:json_annotation/json_annotation.dart';

part 'messages_api_models.g.dart';

@JsonSerializable()
class SendMessageRequest {
  String from;
  String to;
  String? msg;
  String? documentUrl;
  String? imageUrl;

  String? caption;
  String? filename;

  SendMessageRequest(
      {required this.from,
      required this.to,
      this.msg,
      this.documentUrl,
      this.imageUrl,
      this.caption,
      this.filename});

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}

@JsonSerializable()
class SendMessageResponse {
  SendMessageResult? result; // null if error

  SendMessageResponse({this.result});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageResponseToJson(this);
}

@JsonSerializable()
class SendMessageResult {
  String messageId;
  String phoneNumber;
  String whatsappId;

  SendMessageResult(
      {required this.messageId,
      required this.phoneNumber,
      required this.whatsappId});

  factory SendMessageResult.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResultFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageResultToJson(this);
}
