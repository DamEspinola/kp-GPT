import 'package:yes_no_app/domain/entities/chatMessage.dart';
import 'package:yes_no_app/domain/repositories/chat_repository.dart';

class SendChatMessage {
  final ChatRepository repository;

  SendChatMessage({required this.repository});

  Future<ChatMessage> execute(String message) async {
    final chatMessage = await repository.sendMessage(message);
    return chatMessage;
  }
}
