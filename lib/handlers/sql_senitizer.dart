/// a function that checks if the input has sql commands
bool sanitizeInput(String input) {
  // make sure this string has no sql injection
  if (hasSqlCommands(input)) {
    return true;
  } else {
    return false;
  }
}

/// a function that checks if the input has sql commands
bool hasSqlCommands(String input) {
  // make sure this string has no sql injection
  final decision = input.contains('SELECT') ||
      input.contains('INSERT') ||
      input.contains('UPDATE') ||
      input.contains('DELETE') ||
      input.contains('DROP') ||
      input.contains('CREATE') ||
      input.contains('ALTER') ||
      input.contains('TRUNCATE') ||
      input.contains('RENAME') ||
      input.contains('GRANT') ||
      input.contains('REVOKE') ||
      input.contains('ROLLBACK') ||
      input.contains('COMMIT') ||
      input.contains('SAVEPOINT') ||
      input.contains('LOCK') ||
      input.contains('UNLOCK') ||
      input.contains('PREPARE') ||
      input.contains('EXECUTE') ||
      input.contains('FETCH') ||
      input.contains('COPY') ||
      input.contains('MOVE') ||
      input.contains('LISTEN') ||
      input.contains('NOTIFY') ||
      input.contains('UNLISTEN') ||
      input.contains('DISCARD') ||
      input.contains('EXPLAIN') ||
      input.contains('ANALYZE') ||
      input.contains('DEALLOCATE') ||
      input.contains('DECLARE') ||
      input.contains('=') ||
      input.contains('>') ||
      input.contains('<') ||
      input.contains('!') ||
      input.contains("'");

  return decision;
}
