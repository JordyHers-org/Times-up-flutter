class EmailModel {
  EmailModel({
    required this.emailIds,
    required this.subject,
    required this.text,
    required this.html,
  });

  final List<String> emailIds;
  final String subject;
  final String text;
  final String html;

  Map<String, dynamic> toJson() {
    return {
      'to': emailIds,
      'message': {
        'subject': subject,
        'text': text,
        'html': html,
      },
    };
  }
}
