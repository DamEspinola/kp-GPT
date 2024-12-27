import 'package:yes_no_app/data/model/chat_message_model.dart';
import 'package:yes_no_app/domain/entities/chatMessage.dart';

import '../../domain/repositories/chat_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GenerativeModel _model;

  ChatRepositoryImpl(this._model);

  @override
  Future<ChatMessage> sendMessage(String message) async {
    final chatSession = _model.startChat();
    final response = await chatSession.sendMessage(Content.text(message));
    return ChatMessageModel.fromApi({'text': response.text, 'role': 'assistant'});
  }
}
