import "package:flutter/material.dart";

const int topSize = 50;

class AppBarBuilderUI extends StatefulWidget {
  final ScrollController scrollController;
  final bool reversed;

  final Widget Function(BuildContext context, double opacity, double offset) builder;
  final Widget Function(BuildContext context, double opacity, double offset) appBarContent;

  AppBarBuilderUI({
    Key? key,
    required this.scrollController,
    required this.builder,
    required this.appBarContent,
    this.reversed = false,
  }) : super(key: key);
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
            color: Theme.of(context).colorScheme.background.withOpacity(_topBarOpacity),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
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
