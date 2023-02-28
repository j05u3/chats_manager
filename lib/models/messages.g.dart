// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      phones: (json['phones'] as List<dynamic>?)
          ?.map((e) => Phone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'phones': instance.phones,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      first_name: json['first_name'] as String?,
      formatted_name: json['formatted_name'] as String?,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'formatted_name': instance.formatted_name,
    };

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      wa_id: json['wa_id'] as String?,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'phone': instance.phone,
      'type': instance.type,
      'wa_id': instance.wa_id,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      text: json['text'] as String?,
      context: json['context'] == null
          ? null
          : Context.fromJson(json['context'] as Map<String, dynamic>),
      id: json['id'] as String?,
      title: json['title'] as String?,
      payload: json['payload'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      media_url: json['media_url'] as String?,
      mime_type: json['mime_type'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'text': instance.text,
      'context': instance.context,
      'id': instance.id,
      'title': instance.title,
      'payload': instance.payload,
      'media_url': instance.media_url,
      'mime_type': instance.mime_type,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => ErrorData(
      details: json['details'] as String?,
    );

Map<String, dynamic> _$ErrorDataToJson(ErrorData instance) => <String, dynamic>{
      'details': instance.details,
    };

StatusError _$StatusErrorFromJson(Map<String, dynamic> json) => StatusError(
      code: json['code'] as int?,
      title: json['title'] as String?,
      error_data: json['error_data'] == null
          ? null
          : ErrorData.fromJson(json['error_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatusErrorToJson(StatusError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'error_data': instance.error_data,
    };

StatusReceived _$StatusReceivedFromJson(Map<String, dynamic> json) =>
    StatusReceived(
      timestamp: json['timestamp'] as String?,
      status: json['status'] as String?,
      recipient_id: json['recipient_id'] as String?,
      id: json['id'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => StatusError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusReceivedToJson(StatusReceived instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'recipient_id': instance.recipient_id,
      'id': instance.id,
      'errors': instance.errors,
    };

OutgoingMessage _$OutgoingMessageFromJson(Map<String, dynamic> json) =>
    OutgoingMessage(
      requestBody: json['requestBody'] == null
          ? null
          : RequestBody.fromJson(json['requestBody'] as Map<String, dynamic>),
      t: json['t'] as int?,
      fromPhoneNumberId: json['fromPhoneNumberId'] as String?,
      responseSummary: json['responseSummary'] == null
          ? null
          : ResponseSummary.fromJson(
              json['responseSummary'] as Map<String, dynamic>),
      lastStatus_sent: json['lastStatus_sent'] == null
          ? null
          : StatusReceived.fromJson(
              json['lastStatus_sent'] as Map<String, dynamic>),
      lastStatus_delivered: json['lastStatus_delivered'] == null
          ? null
          : StatusReceived.fromJson(
              json['lastStatus_delivered'] as Map<String, dynamic>),
      lastStatus_read: json['lastStatus_read'] == null
          ? null
          : StatusReceived.fromJson(
              json['lastStatus_read'] as Map<String, dynamic>),
      lastStatus_failed: json['lastStatus_failed'] == null
          ? null
          : StatusReceived.fromJson(
              json['lastStatus_failed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OutgoingMessageToJson(OutgoingMessage instance) =>
    <String, dynamic>{
      'requestBody': instance.requestBody,
      't': instance.t,
      'fromPhoneNumberId': instance.fromPhoneNumberId,
      'responseSummary': instance.responseSummary,
      'lastStatus_sent': instance.lastStatus_sent,
      'lastStatus_delivered': instance.lastStatus_delivered,
      'lastStatus_read': instance.lastStatus_read,
      'lastStatus_failed': instance.lastStatus_failed,
    };

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) => RequestBody(
      to: json['to'] as String?,
      text: json['text'] == null
          ? null
          : Text.fromJson(json['text'] as Map<String, dynamic>),
      template: json['template'] == null
          ? null
          : Template.fromJson(json['template'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      interactive: json['interactive'] == null
          ? null
          : Interactive.fromJson(json['interactive'] as Map<String, dynamic>),
      recipientType: json['recipientType'] as String?,
      messagingProduct: json['messagingProduct'] as String?,
      type: json['type'] as String?,
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
    )..document = json['document'] == null
        ? null
        : Document.fromJson(json['document'] as Map<String, dynamic>);

Map<String, dynamic> _$RequestBodyToJson(RequestBody instance) =>
    <String, dynamic>{
      'to': instance.to,
      'text': instance.text,
      'template': instance.template,
      'location': instance.location,
      'interactive': instance.interactive,
      'recipientType': instance.recipientType,
      'messagingProduct': instance.messagingProduct,
      'type': instance.type,
      'image': instance.image,
      'document': instance.document,
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      name: json['name'] as String,
      components: (json['components'] as List<dynamic>?)
          ?.map((e) => TemplateComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'name': instance.name,
      'components': instance.components,
    };

TemplateComponent _$TemplateComponentFromJson(Map<String, dynamic> json) =>
    TemplateComponent(
      type: json['type'] as String,
      parameters: (json['parameters'] as List<dynamic>?)
          ?.map((e) => Parameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateComponentToJson(TemplateComponent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'parameters': instance.parameters,
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) => Parameter(
      type: json['type'] as String,
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'type': instance.type,
      'image': instance.image,
      'text': instance.text,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'link': instance.link,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      link: json['link'] as String?,
      filename: json['filename'] as String?,
      caption: json['caption'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'link': instance.link,
      'filename': instance.filename,
      'caption': instance.caption,
    };
