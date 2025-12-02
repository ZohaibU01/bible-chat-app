import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessageController extends GetxController {
  var messages = <Message>[].obs;
  var messageController = TextEditingController();

  final String apiKey = "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";
  final String assistantId = "asst_YY1rdZZriESAEAzSD1jRGCPR";
  String _threadId = "";

  RxBool isLoading = false.obs;

  void sendMessage(String text, bool isMe) async {
    if (text.trim().isEmpty) return;

    isLoading.value = true;

    try{
      messages.add(Message(text: text, isMe: true));
      messageController.clear();

      if (_threadId.isEmpty) {
        _threadId = await createThread();
      }

      await addMessageToThread(_threadId, text);
      await runAssistantAndWait(_threadId);
      String botResponse = await getAssistantResponse(_threadId);
      messages.add(Message(text: botResponse, isMe: false));
    }
    catch(e,s){
      print("$e $s");
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<String> createThread() async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/threads"),
      headers: _headers,
    );
    final data = jsonDecode(response.body);
    return data["id"];
  }

  Future<void> addMessageToThread(String threadId, String userMessage) async {
    await http.post(
      Uri.parse("https://api.openai.com/v1/threads/$threadId/messages"),
      headers: _headers,
      body: jsonEncode({"role": "user", "content": userMessage}),
    );
  }

  Future<void> runAssistantAndWait(String threadId) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/threads/$threadId/runs"),
      headers: _headers,
      body: jsonEncode({"assistant_id": assistantId}),
    );
    final runId = jsonDecode(response.body)["id"];
    await _waitForRunCompletion(threadId, runId);
  }

  Future<void> _waitForRunCompletion(String threadId, String runId) async {
    while (true) {
      final response = await http.get(
        Uri.parse("https://api.openai.com/v1/threads/$threadId/runs/$runId"),
        headers: _headers,
      );
      final status = jsonDecode(response.body)["status"];
      if (status == "completed") break;
      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<String> getAssistantResponse(String threadId) async {
    final response = await http.get(
      Uri.parse("https://api.openai.com/v1/threads/$threadId/messages"),
      headers: _headers,
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var msg in data["data"]) {
      if (msg["role"] == "assistant") {
        for (var content in msg["content"]) {
          if (content["type"] == "text") {
            return content["text"]["value"].replaceAll("*", "");
          }
        }
      }
    }
    return "No assistant response found.";
  }

  Map<String, String> get _headers => {
    "Authorization": "Bearer $apiKey",
    "Content-Type": "application/json",
    "OpenAI-Beta": "assistants=v2"
  };
}

class Message {
  final String text;
  final bool isMe;
  Message({required this.text, required this.isMe});
}
