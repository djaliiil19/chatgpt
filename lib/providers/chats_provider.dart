import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {

  List<ChatModel>chatList = [];
  List<ChatModel> get getChatList => chatList;

  void addUserMessage({required String msg}){
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String selectedModelId}
  ) async {
    selectedModelId.toLowerCase().startsWith("gpt")
        ? chatList.addAll(
        await ApiService.sendMessageGPT(
            message: msg,
            modelId: selectedModelId,
        )
    )
        : chatList.addAll(
        await ApiService.sendMessage(
            message: msg,
            modelId: selectedModelId,
        )
    );
    notifyListeners();
  }

}