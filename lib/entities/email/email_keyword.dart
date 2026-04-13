import 'package:equatable/equatable.dart';

class EmailKeyword with EquatableMixin {
  static final draft = EmailKeyword("\$draft");
  static final seen = EmailKeyword("\$seen");
  static final flagged = EmailKeyword("\$flagged");
  static final answered = EmailKeyword("\$answered");
  static final forwarded = EmailKeyword("\$forwarded");
  static final phishing = EmailKeyword("\$phishing");
  static final junk = EmailKeyword("\$junk");
  static final notJunk = EmailKeyword("\$notjunk");
  static final mdnSent = EmailKeyword("\$mdnsent");

  final String _value;

  const EmailKeyword(String value) : _value = value;

  String get value => _value;

  @override
  List<Object> get props => [_value];
}
