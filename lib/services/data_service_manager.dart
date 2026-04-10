// import 'package:flutter/foundation.dart';

// import './hive_datasource.dart';
// import './sqlite_datasource.dart';
// import './remote_datasource.dart';
// import './datasource.dart';

// //WIP

// class DataServiceManager {
//   late final IDataSource _local; //set in constructor
//   final IDataSource _remote = RemoteDatasource();

//   DataServiceManager() {
//     if (kIsWeb) {
//       _local = HiveDatasource();
//     } else {
//       _local = SqliteDatasource();
//     }
//   }

//   // Future<bool> _isOnline() async {
//   //   //
//   // }
// }
