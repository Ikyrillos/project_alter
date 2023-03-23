import 'package:dotenv/dotenv.dart';
import 'package:postgres_pool/postgres_pool.dart';

/// This class is used to connect to the database
DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

/// This class is used to connect to the database
final pg = PgPool(
  PgEndpoint(
    host: env['postgresHost']!,
    database: 'postgres',
    username: env['postgresUser'],
    password: env['postgresPassword'],
    port: int.parse(env['postgresPort']!),
  ),
  settings: PgPoolSettings()
    ..maxConnectionAge = const Duration(hours: 1)
    ..concurrency = 4,
);

// jwt secret
/// jwtSecret is a string from .env file
final jwtSecret = env['jwtSecret'].toString();
