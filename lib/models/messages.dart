import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

class IncomingMessage {
  String? toPhoneNumberId;
  int? t;
  String? type;
  String? from;
  String? id;
  Data? data;
  String? name;
  String? timestamp;

  IncomingMessage(
      {this.toPhoneNumberId,
      this.t,
      this.type,
      this.from,
      this.id,
      this.data,
      this.name,
      this.timestamp});

  IncomingMessage.fromJson(Map<String, dynamic> json) {
    toPhoneNumberId = json['to_phone_number_id'];
    t = json['t'];
    type = json['type'];
    from = json['from'];
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    name = json['name'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_phone_number_id'] = this.toPhoneNumberId;
    data['t'] = this.t;
    data['type'] = this.type;
    data['from'] = this.from;
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['name'] = this.name;
    data['timestamp'] = this.timestamp;
    return data;
  }
}


@JsonSerializable()
class Data {
  String? text;
  Context? context;
  String? id;
  String? title;
  String? payload;

  // location
  double? latitude;
  double? longitude;

  Data(
      {this.text,
      this.context,
      this.id,
      this.title,
      this.payload,
      this.latitude,
      this.longitude});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

class Context {
  String? id;
  String? from;

  Context({this.id, this.from});

  Context.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    return data;
  }
}

class OutgoingMessage {
  RequestBody? requestBody;
  int? t;
  String? fromPhoneNumberId;
  ResponseSummary? responseSummary;

  OutgoingMessage(
      {this.requestBody, this.t, this.fromPhoneNumberId, this.responseSummary});

  OutgoingMessage.fromJson(Map<String, dynamic> json) {
    requestBody = json['requestBody'] != null
        ? new RequestBody.fromJson(json['requestBody'])
        : null;
    t = json['t'];
    fromPhoneNumberId = json['fromPhoneNumberId'];
    responseSummary = json['responseSummary'] != null
        ? new ResponseSummary.fromJson(json['responseSummary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestBody != null) {
      data['requestBody'] = this.requestBody!.toJson();
    }
    data['t'] = this.t;
    data['fromPhoneNumberId'] = this.fromPhoneNumberId;
    if (responseSummary != null) {
      data['responseSummary'] = this.responseSummary!.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class RequestBody {
  String? to;
  Text? text;
  Template? template;
  Location? location;
  Interactive? interactive;
  String? recipientType;
  String? messagingProduct;
  String? type;
  Image? image;

  RequestBody(
      {this.to,
      this.text,
      this.template,
      this.location,
      this.interactive,
      this.recipientType,
      this.messagingProduct,
      this.type,
      this.image});
      
  factory RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RequestBodyToJson(this);
}

class Interactive {
  Data? body;

  Interactive({this.body});

  Interactive.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Data.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({required this.latitude, required this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

@JsonSerializable()
class Template {
  final String name;
  final List<TemplateComponent>? components;

  Template({required this.name, this.components});

  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}

@JsonSerializable()
class TemplateComponent {
  final String type;
  final List<Parameter>? parameters;

  TemplateComponent({required this.type, this.parameters});

  factory TemplateComponent.fromJson(Map<String, dynamic> json) =>
      _$TemplateComponentFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateComponentToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final Image? image;
  final String? text;

  Parameter({required this.type, this.image, this.text});

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Image {
  final String? link;

  Image({this.link});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

class Text {
  String? body;

  Text({this.body});

  Text.fromJson(Map<String, dynamic> json) {
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    return data;
  }
}

class ResponseSummary {
  String? whatsappId;
  String? phoneNumber;
  String? messageId;

  ResponseSummary({this.whatsappId, this.phoneNumber, this.messageId});

  ResponseSummary.fromJson(Map<String, dynamic> json) {
    whatsappId = json['whatsappId'];
    phoneNumber = json['phoneNumber'];
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatsappId'] = this.whatsappId;
    data['phoneNumber'] = this.phoneNumber;
    data['messageId'] = this.messageId;
    return data;
  }
}

class Message {
  String id;
  int t;
  IncomingMessage? incomingMessage;
  OutgoingMessage? outgoingMessage;

  Message(
      {required this.id,
      required this.t,
      this.incomingMessage,
      this.outgoingMessage});
}
