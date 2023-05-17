import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ViewModule extends StatelessWidget {
  const ViewModule({
    required WidgetBuilder builder,
    List<SingleChildWidget>? bindings,
    super.key,
  })  : _builder = builder,
        _bindings = bindings;

  final WidgetBuilder _builder;

  final List<SingleChildWidget>? _bindings;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings != null && _bindings!.isNotEmpty
          ? _bindings!
          : [
              Provider(
                create: (context) => Object(),
              ),
            ],
      builder: (context, child) => _builder(context),
    );
  }
}
