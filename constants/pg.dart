import 'package:dotenv/dotenv.dart';

DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

final postgresHost = env['postgresHost'];
final postgresPort = int.parse(env['postgresPort']!);
final postgresUser = env['postgresUser'];
final postgresPassword = env['postgresPassword'];
final jwtSecret = env['jwtSecret'].toString();
