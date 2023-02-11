// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
      from: json['from'] as String,
      to: json['to'] as String,
      msg: json['msg'] as String?,
      documentUrl: json['documentUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      caption: json['caption'] as String?,
      filename: json['filename'] as String?,
    );

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'msg': instance.msg,
      'documentUrl': instance.documentUrl,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'filename': instance.filename,
    };

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) =>
    SendMessageResponse(
      result: json['result'] == null
          ? null
          : SendMessageResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendMessageResponseToJson(
        SendMessageResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

SendMessageResult _$SendMessageResultFromJson(Map<String, dynamic> json) =>
    SendMessageResult(
      messageId: json['messageId'] as String,
      phoneNumber: json['phoneNumber'] as String,
      whatsappId: json['whatsappId'] as String,
    );

Map<String, dynamic> _$SendMessageResultToJson(SendMessageResult instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'phoneNumber': instance.phoneNumber,
      'whatsappId': instance.whatsappId,
    };
