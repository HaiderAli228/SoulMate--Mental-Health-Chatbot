import 'dart:convert';
import 'package:http/http.dart' as http;

class ClaudeService {
  final String apiKey = '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';

  Future<String> getResponse(String userInput) async {
    final url = Uri.parse('https://api.anthropic.com/v1/messages');

    print('Starting API request...');
    print('User input: $userInput');

    try {
      print('Sending POST request to URL: $url');

      final response = await http.post(
        url,
        headers: {
          'x-api-key': apiKey, // Correct header for API key
          'anthropic-version': '2023-06-01', // Mandatory version header
          'Content-Type': 'application/json', // Correct header for JSON content
        },
        body: jsonEncode({
          'model': 'claude-3-5-sonnet-20241022', // Model identifier from the API docs
          'max_tokens': 1024, // Token limit for the response
          'messages': [
            {
              'role': 'user', // Role must be "user" for user input
              'content': userInput, // User query
            },
          ],
        }),
      );

      print('Response received. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final completion = data['completion'];
        print('Parsed response: $completion');
        return completion ?? 'No response received from the API.';
      } else {
        print('Error response received. Status code: ${response.statusCode}');
        return 'Error: Unable to connect to the chatbot. Status Code: ${response.statusCode}. Message: ${response.body}';
      }
    } catch (e) {
      print('Exception occurred during API request: $e');
      return 'Error: Failed to connect to the API. Exception: $e';
    }
  }
}
