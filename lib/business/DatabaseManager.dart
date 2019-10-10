import 'package:sqflite/sqlite_api.dart';
import 'package:weather_app/business/provider/DatabaseProvider.dart';
import 'package:weather_app/Models/Locations.dart';

class DatabaseManager {
  Future<void> insertLocation(Location location) async {
    DatabaseProvider databaseProvider = await DatabaseProvider();
    await databaseProvider.open();
    Database db = await databaseProvider.db;

    await deleteAll();

    int id = location.id;
    var name = location.name;
    var country = location.country;
    var lon = location.coord.lon;
    var lat = location.coord.lat;

    await db.rawInsert(
        'INSERT INTO set_location(location_id, name, country) VALUES($id, "$name", "$country")');
    await db.rawInsert(
        'INSERT INTO coord(coord_id, lon, lat) VALUES($id, "$lon", "$lat")');
  }

  Future<void> deleteAll() async {
    DatabaseProvider databaseProvider = await DatabaseProvider();
    await databaseProvider.open();
    Database db = await databaseProvider.db;

    await db.rawDelete("DELETE FROM coord");
    await db.rawDelete('DELETE FROM set_location');
  }

  Future<String> getIdLocation() async {
    DatabaseProvider databaseProvider = await DatabaseProvider();
    await databaseProvider.open();
    Database db = await databaseProvider.db;

    List<Map> listId =
        await db.rawQuery('SELECT location_id FROM set_location');

    if (listId.length > 0)
      return listId[0]['location_id'].toString();
    else
      return null;
  }

}
