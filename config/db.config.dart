import 'package:postgres_pool/postgres_pool.dart';

import '../constants/pg.dart';

final pg = PgPool(
  PgEndpoint(
    host: 'localhost',
    database: 'postgres',
    username: postgresUser,
    password: postgresPassword,
  ),
  settings: PgPoolSettings()
    ..maxConnectionAge = const Duration(hours: 1)
    ..concurrency = 4,
);
