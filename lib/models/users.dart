class UserMessageStatus {
  int? lastIncomingMessageTimestamp;
  int? incomingMessagesCount;
  int? lastOutgoingMessageTimestamp;
  String? lastIncomingMessageDocId;
  String? lastOutgoingMessageDocId;
  int? outgoingMessagesCount;
  int? lastMessageTimestamp;

  UserMessageStatus(
      {this.lastIncomingMessageTimestamp,
      this.incomingMessagesCount,
      this.lastOutgoingMessageTimestamp,
      this.lastIncomingMessageDocId,
      this.lastOutgoingMessageDocId,
      this.outgoingMessagesCount,
      this.lastMessageTimestamp});

  UserMessageStatus.fromJson(Map<String, dynamic> json) {
    lastIncomingMessageTimestamp = json['last_incoming_message_timestamp'];
    incomingMessagesCount = json['incoming_messages_count'];
    lastOutgoingMessageTimestamp = json['last_outgoing_message_timestamp'];
    lastIncomingMessageDocId = json['last_incoming_message_doc_id'];
    lastOutgoingMessageDocId = json['last_outgoing_message_doc_id'];
    outgoingMessagesCount = json['outgoing_messages_count'];
    lastMessageTimestamp = json['last_message_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_incoming_message_timestamp'] = this.lastIncomingMessageTimestamp;
    data['incoming_messages_count'] = this.incomingMessagesCount;
    data['last_outgoing_message_timestamp'] = this.lastOutgoingMessageTimestamp;
    data['last_incoming_message_doc_id'] = this.lastIncomingMessageDocId;
    data['last_outgoing_message_doc_id'] = this.lastOutgoingMessageDocId;
    data['outgoing_messages_count'] = this.outgoingMessagesCount;
    data['last_message_timestamp'] = this.lastMessageTimestamp;
    return data;
  }
}

class UserMessagingProfile {
  String? name;

  UserMessagingProfile({this.name});

  UserMessagingProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class User {
  String id; // phone number with country code (WhatsApp style)
  UserMessageStatus status;
  UserMessagingProfile profile;

  User({required this.id, required this.status, required this.profile});
}
