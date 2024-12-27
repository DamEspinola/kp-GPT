import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  List<Message> messagesList = [];
  // Message(text: "Hola mi vida", fromWho: FromWho.me)

  final Map<String, String> faq = {
    "Hola": "Hola mi vida.",
    "Cómo estás?": "Estoy bien y vos ?.",
    "Qué haces?": "Hablando contigo 😊.",
    "Por qué el cielo es azul?": "Por la dispersión de la luz en la atmósfera.",
  };


  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messagesList.add(newMessage);

    if (faq.containsKey(text)) {
      _showTypingAnimation();
      await Future.delayed(const Duration(seconds: 2));
      final answer = faq[text]!;
      messagesList.add(Message(text: answer, fromWho: FromWho.hers));
      _hideTypingAnimation();
      notifyListeners();
      moveScrollToBottom();
      return;
    }
    // AIzaSyD_VCpIFCA_bwDjPtlW1o0NpGms9pOiBBE

    // Preguntas generales o no mapeadas
    // if (text.endsWith("?")) {
    //   _showTypingAnimation();
    //   await Future.delayed(const Duration(seconds: 2));
    //   await herReply();
    // }

    // if (text.endsWith("?")) {
    //   _showTypingAnimation();
    //     await Future.delayed(Duration(seconds: 2));
    //   herReply();
    // }
    // if (text.startsWith("Hola")) {
    //   _showTypingAnimation();
    //     await Future.delayed(Duration(seconds: 2));

    //   herGreeting();
    // }

    // notifyListeners();
    // moveScrollToBottom();
  }

  

  void _showTypingAnimation() {
    _isTyping = true;
    notifyListeners();
  }

  void _hideTypingAnimation() {
    _isTyping = false;
    notifyListeners();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    if (herMessage.text.isEmpty) return;

    messagesList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herGreeting() async {
    final herRespMessage =
        Message(text: "Hola mi corazón", fromWho: FromWho.hers);

    if (herRespMessage.text.isEmpty) return;

    messagesList.add(herRespMessage);
    _hideTypingAnimation();
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut);
  }
}
