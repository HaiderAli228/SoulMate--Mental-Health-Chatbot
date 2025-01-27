import 'package:flutter/material.dart';
import '../services/claude_services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ClaudeService _claudeService = ClaudeService();

  bool _isLoading = false;

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) {
      print('Error: User tried to send an empty message.');
      return;
    }

    final userInput = _messageController.text.trim();
    print('User input: $userInput');

    setState(() {
      _messages.add({'sender': 'user', 'message': userInput});
      _isLoading = true;
    });

    try {
      print('Calling ClaudeService to get response...');
      final response = await _claudeService.getResponse(userInput);
      print('Response from ClaudeService: $response');

      setState(() {
        _messages.add({'sender': 'bot', 'message': response});
        _messageController.clear();
      });
    } catch (e) {
      print('Error while getting response from ClaudeService: $e');
      setState(() {
        _messages.add({'sender': 'bot', 'message': 'Error: $e'});
      });
    } finally {
      print('Finished processing message.');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Claude'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message['message'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
