String? sanitizeHtmlUrl(String? url) {
  if (url == null) return null;

  final sanitized = url.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  if (sanitized.isEmpty) return null;

  final uri = Uri.tryParse(sanitized);
  if (uri == null || !uri.isAbsolute) return null;

  return sanitized;
}
