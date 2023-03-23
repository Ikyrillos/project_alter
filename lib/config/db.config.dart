import 'package:dotenv/dotenv.dart';
import 'package:postgres_pool/postgres_pool.dart';

DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

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
final jwtSecret = env['jwtSecret'].toString();
