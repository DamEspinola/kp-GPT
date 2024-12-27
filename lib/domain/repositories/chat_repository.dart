import 'package:yes_no_app/domain/entities/chatMessage.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(String message);
}
