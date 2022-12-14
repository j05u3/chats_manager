// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    );

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
