import "package:flutter/material.dart";

const int topSize = 50;

class AppBarBuilderUI extends StatefulWidget {
  final ScrollController scrollController;
  final bool reversed;

  final Widget Function(BuildContext context, double opacity, double offset) builder;
  final Widget Function(BuildContext context, double opacity, double offset) appBarContent;
  final Color Function(BuildContext context, double opacity) appBarBackgroundBuilder;
  final BoxShadow Function(BuildContext context, double opacity) boxShadowBuilder;
  AppBarBuilderUI({
    Key? key,
    required this.scrollController,
    required this.builder,
    required this.appBarContent,
    Color Function(BuildContext context, double opacity)? appBarBackgroundBuilder,
    BoxShadow Function(BuildContext context, double opacity)? boxShadowBuilder,
    this.reversed = false,
  })  : appBarBackgroundBuilder = appBarBackgroundBuilder ?? _defaultAppBarBackgroundBuilder,
        boxShadowBuilder = boxShadowBuilder ?? _defaultBoxShadowBuilder,
        super(key: key);
  @override
  State<AppBarBuilderUI> createState() => _AppBarBuilderUIState();
}

class _AppBarBuilderUIState extends State<AppBarBuilderUI> {
  late final ScrollController _scrollController;

  double _topBarOpacity = 0.0;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        setState(
          () {
            double _scrollOffsetReversed = _scrollController.position.maxScrollExtent - _scrollController.offset;
            _scrollOffset = widget.reversed ? _scrollOffsetReversed : _scrollController.offset;
          },
        );
        if (_scrollOffset >= topSize) {
          if (_topBarOpacity != 1.0) setState(() => _topBarOpacity = 1.0);
        } else if (_scrollOffset <= topSize && _scrollOffset >= 0) {
          setState(() => _topBarOpacity = _scrollOffset / topSize);
        } else if (_scrollOffset <= 0) {
          if (_topBarOpacity != 0.0) setState(() => _topBarOpacity = 0.0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height,
          ),
          child: widget.builder(context, _topBarOpacity, _scrollOffset),
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.appBarBackgroundBuilder(context, _topBarOpacity),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            boxShadow: <BoxShadow>[
              widget.boxShadowBuilder(context, 0.5 * _topBarOpacity),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 12 + MediaQuery.of(context).padding.top,
              bottom: 12 - 8.0 * _topBarOpacity,
            ),
            child: widget.appBarContent(context, _topBarOpacity, _scrollOffset),
          ),
        ),
      ],
    );
  }
}

Color _defaultAppBarBackgroundBuilder(
  BuildContext context,
  double opacity,
) {
  return Theme.of(context).colorScheme.background.withOpacity(opacity);
}

BoxShadow _defaultBoxShadowBuilder(
  BuildContext context,
  double opacity,
) {
  return BoxShadow(
    color: Colors.grey.withOpacity(opacity),
    offset: Offset(1.1, 1.1),
    blurRadius: 10.0,
  );
}
