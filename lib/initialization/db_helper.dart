class DbHelper {
  Future<void> init() async {
    // Some process for initialising the local database
    // e.g. opening the database, creating tables if not existing
    await Future<void>.delayed(const Duration(seconds: 3));
    print('DB is ready.');
  }
}
