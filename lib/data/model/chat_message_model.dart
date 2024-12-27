
import 'package:yes_no_app/domain/entities/chatMessage.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({
    required String text,
    required bool isFromUser,
  }) : super(text: text, isFromUser: isFromUser);

  factory ChatMessageModel.fromApi(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'],
      isFromUser: json['role'] == 'user',
    );
  }
}
