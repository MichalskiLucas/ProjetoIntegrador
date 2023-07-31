import 'dart:async';

import 'package:cookmaster_front/app/data/models/chatgpt_model.dart';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:rxdart/rxdart.dart';

import '../atoms/chat_atom.dart';
import 'package:cookmaster_front/config/constants.dart';

class ChatReducer extends RxReducer {
  final chatGpt = ChatGpt(apiKey: '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');

  ChatReducer() {
    on(() => [sendMessageAction.value], sendMessage);
  }

  void sendMessage() async {
    final message = sendMessageAction.value;
    if (message.isEmpty) {
      return;
    }

    chatLoading.value = true;

    chatsState.insert(0, ChatModel(text: message, isSender: true));
    chatsState.insert(0, ChatModel(text: '...', isSender: false));
    
    //Linha abaixo serve para filtrar o nicho de respostas do chat
    String _systemMessage =
       "Você está se comunicando com um assistente de receitas. Pergunte sobre receitas.";

    final request = CompletionRequest(
      stream: true,
      maxTokens: 4000,
      model: ChatGptModel.gpt35Turbo,
      messages: [
        Message(role: Role.user.name, content: message),
        Message(role: Role.system.name, content: _systemMessage),
      ],
    );

    final stream = await chatGpt.createChatCompletionStream(request);

    if (stream == null) {
      chatLoading.value = false;
      return;
    }

    final completer = Completer();
    final buffer = StringBuffer();

    final sup = stream //
        .interval(const Duration(milliseconds: 100))
        .listen((event) {
      if (event.streamMessageEnd) {
        completer.complete();
      }

      final buffedMessage = event.choices?.first.delta?.content ?? '';
      buffer.write(buffedMessage);
      final updatedChat = chatsState[0].copyWith(text: buffer.toString());
      chatsState[0] = updatedChat;
    });

    await completer.future;
    chatLoading.value = false;
    await sup.cancel();
  }
}
