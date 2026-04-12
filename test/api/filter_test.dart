import 'package:jmap_dart_client/api/api.dart';
import 'package:test/test.dart';

class _TestFilterConditionRaw extends FilterCondition {
  final String? role;
  final bool? isSubscribed;
  final bool? hasAnyRole;

  _TestFilterConditionRaw({this.role, this.isSubscribed, this.hasAnyRole});

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (role != null) json['role'] = role;
    if (isSubscribed != null) json['isSubscribed'] = isSubscribed;
    if (hasAnyRole != null) json['hasAnyRole'] = hasAnyRole;

    return json;
  }
}

typedef _TestFilter = Filter<_TestFilterConditionRaw>;

class _TestFilterCondition
    extends FilterConditionBase<_TestFilterConditionRaw> {
  _TestFilterCondition({String? role, bool? isSubscribed, bool? hasAnyRole})
    : super(
        _TestFilterConditionRaw(
          role: role,
          isSubscribed: isSubscribed,
          hasAnyRole: hasAnyRole,
        ),
      );
}

class _TestFilterOperator extends FilterOperatorBase<_TestFilterConditionRaw> {
  _TestFilterOperator(super.operator, super.conditions);
}

// Keeps typedef usage explicit in a standalone function signature.
Map<String, dynamic> _serializeTypedFilter(_TestFilter filter) =>
    filter.toJson();

void main() {
  group('Filter API', () {
    test('FilterConditionBase serializes wrapped condition JSON', () {
      final filter = _TestFilterCondition(role: 'Spam');

      expect(filter.toJson(), {'role': 'Spam'});
    });

    test('FilterOperatorBase serializes operator and child conditions', () {
      final filter = _TestFilterOperator(Operator.AND, [
        _TestFilterCondition(role: 'Inbox'),
        _TestFilterCondition(isSubscribed: true),
      ]);

      expect(filter.toJson(), {
        'operator': 'AND',
        'conditions': [
          {'role': 'Inbox'},
          {'isSubscribed': true},
        ],
      });
    });

    test('supports nested logical filter trees from the docs', () {
      final _TestFilter filter = _TestFilterOperator(Operator.AND, [
        _TestFilterCondition(role: 'Inbox'),
        _TestFilterOperator(Operator.OR, [
          _TestFilterCondition(isSubscribed: true),
          _TestFilterCondition(hasAnyRole: true),
        ]),
      ]);

      expect(filter.toJson(), {
        'operator': 'AND',
        'conditions': [
          {'role': 'Inbox'},
          {
            'operator': 'OR',
            'conditions': [
              {'isSubscribed': true},
              {'hasAnyRole': true},
            ],
          },
        ],
      });
    });

    test('supports NOT operator shape', () {
      final filter = _TestFilterOperator(Operator.NOT, [
        _TestFilterCondition(role: 'Trash'),
      ]);

      expect(filter.toJson(), {
        'operator': 'NOT',
        'conditions': [
          {'role': 'Trash'},
        ],
      });
    });

    test('typedef can be used as a standalone type in separate test', () {
      final _TestFilter condition = _TestFilterCondition(role: 'Archive');
      final _TestFilter operator = _TestFilterOperator(Operator.OR, [
        _TestFilterCondition(hasAnyRole: true),
        _TestFilterCondition(isSubscribed: false),
      ]);

      expect(_serializeTypedFilter(condition), {'role': 'Archive'});
      expect(_serializeTypedFilter(operator), {
        'operator': 'OR',
        'conditions': [
          {'hasAnyRole': true},
          {'isSubscribed': false},
        ],
      });
    });
  });
}
