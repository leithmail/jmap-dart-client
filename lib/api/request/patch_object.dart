class PatchObject {
  static const mailboxIdsProperty = 'mailboxIds';
  static const keywordsProperty = 'keywords';
  static const identityIdsProperty = 'identityIds';

  PatchObject(this.patches);

  final Map<String, dynamic> patches;

  Map<String, dynamic> toJson() => patches;
}
