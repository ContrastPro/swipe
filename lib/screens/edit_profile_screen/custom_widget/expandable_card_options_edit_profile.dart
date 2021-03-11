import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class ExpandableCardOptionsEditProfile extends StatefulWidget {
  final String title;
  final String hintText;
  final List<String> children;
  final ValueChanged<String> onChange;

  const ExpandableCardOptionsEditProfile({
    Key key,
    this.title,
    @required this.hintText,
    this.children,
    @required this.onChange,
  }) : super(key: key);

  @override
  _ExpandableCardOptionsEditProfileState createState() =>
      _ExpandableCardOptionsEditProfileState();
}

class _ExpandableCardOptionsEditProfileState
    extends State<ExpandableCardOptionsEditProfile>
    with SingleTickerProviderStateMixin {
  String _cardTitle;
  bool _isExpanded = false;
  AnimationController _expandController;

  @override
  void initState() {
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _changeState() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  Color _buildColor(int index) {
    if (_cardTitle != null) {
      if (widget.children[index] == _cardTitle) {
        return AppColors.accentColor;
      } else {
        return Colors.black.withAlpha(40);
      }
    } else {
      if (widget.children[index] == widget.hintText) {
        return AppColors.accentColor;
      } else {
        return Colors.black.withAlpha(40);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.title ?? "Title",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withAlpha(10),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _changeState(),
                  child: ListTile(
                    title: Text(
                      _cardTitle ?? widget.hintText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: RotationTransition(
                      turns: Tween(begin: 1.0, end: 0.5).animate(
                        _expandController,
                      ),
                      child: Icon(
                        Icons.expand_more,
                      ),
                    ),
                  ),
                ),
                SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: CurvedAnimation(
                    parent: _expandController,
                    curve: Curves.fastOutSlowIn,
                  ),
                  child: ListView.builder(
                    itemCount: widget.children.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 16.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onChange(widget.children[index]);
                          setState(() => _cardTitle = widget.children[index]);
                          _changeState();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.0,
                          margin: const EdgeInsets.only(right: 5.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.children[index],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black.withAlpha(165),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                width: 18.0,
                                height: 18.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(45.0),
                                  ),
                                  color: _buildColor(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
