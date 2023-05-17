import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'view_module.dart';

abstract class Module {
  Module({
    required Map<String, WidgetBuilder> routes,
    List<SingleChildWidget>? bindings,
  })  : _routes = routes,
        _bindings = bindings;

  final Map<String, WidgetBuilder> _routes;

  final List<SingleChildWidget>? _bindings;

  Map<String, WidgetBuilder> get routes => _routes.map(
        (routeName, builder) => MapEntry(
          routeName,
          (_) => ViewModule(
            builder: builder,
            bindings: _bindings,
          ),
        ),
      );

  Widget getView(BuildContext context, {required String routeName}) {
    final widgetBuilder = _routes[routeName];
    if (widgetBuilder != null) {
      return ViewModule(
        builder: widgetBuilder,
        bindings: _bindings,
      );
    }

    throw ArgumentError.value(routeName);
  }
}
