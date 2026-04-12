import 'package:jmap_dart_client/api/method/argument/argument.dart';
import 'package:jmap_dart_client/api/method/argument/properties/properties.dart';
import 'package:jmap_dart_client/api/method/method.dart';
import 'package:jmap_dart_client/api/method/method_response.dart';
import 'package:jmap_dart_client/api/request/result_reference.dart';
import 'package:jmap_dart_client/entities/core/id.dart';
import 'package:jmap_dart_client/src/converters/id_converter.dart';
import 'package:jmap_dart_client/src/converters/properties_converter.dart';

abstract class GetMethod<R extends MethodResponse, Q extends ResultReference>
    extends MethodWithAccountId<R, Q> {
  final ids = ListArgumentSlot<Id>('ids', IdConverter().toJson);
  final properties = ArgumentSlot<Properties>(
    'properties',
    PropertiesConverter().toJson,
  );

  GetMethod({required super.accountId});

  @override
  get slots => [...super.slots, ids, properties];
}
