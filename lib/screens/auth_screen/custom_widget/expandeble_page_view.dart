import 'package:flutter/material.dart';

class ExpandablePageView extends StatefulWidget {
  final ScrollPhysics physics;
  final PageController pageController;
  final List<Widget> children;
  final ValueChanged<int> onPageChanged;

  const ExpandablePageView({
    Key key,
    this.physics,
    @required this.pageController,
    @required this.children,
    @required this.onPageChanged,
  }) : assert(pageController != null, onPageChanged != null);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    widget.pageController.addListener(() {
      final _newPage = widget.pageController.page.round();
      if (_currentPage != _newPage) {
        setState(() => _currentPage = _newPage);
      }
    });
    super.initState();
  }

  /*@override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }*/

  List<Widget> _sizeReportingChildren() {
    return widget.children
        .asMap()
        .map(
          (index, child) => MapEntry(
            index,
            OverflowBox(
              minHeight: 0,
              maxHeight: double.infinity,
              alignment: Alignment.topCenter,
              child: SizeReportingWidget(
                onSizeChange: (size) =>
                    setState(() => _heights[index] = size?.height ?? 0),
                child: child,
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        physics: widget.physics ?? BouncingScrollPhysics(),
        controller: widget.pageController,
        children: _sizeReportingChildren(),
        onPageChanged: (int index) => widget.onPageChanged(index),
      ),
    );
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key key,
    @required this.child,
    @required this.onSizeChange,
  }) : super(key: key);

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size _oldSize;

  void _notifySize() {
    final size = context?.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }
}
