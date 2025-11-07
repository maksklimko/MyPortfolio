import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({super.key, required this.items, this.spacing = 16});
  final List<Widget> items;

  final double spacing;

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  /// The index of the item that is currently checking if it is visible
  int checkIndex = 0;

  late final List<GlobalKey> _itemKeys = List.generate(
    widget.items.length,
    (index) => GlobalKey(),
  );

  late final List<bool> _itemVisibility = List.generate(
    widget.items.length,
    (index) => false,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!mounted) return;
      _checkItemVisibility(checkIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _checkItemVisibility(int index) {
    //
    final screenSize = MediaQuery.of(context).size;

    final itemKey = _itemKeys[index];
    final itemRect = itemKey.currentContext?.findRenderObject() as RenderBox?;
    if (itemRect == null) return;

    final itemPosition = itemRect.localToGlobal(Offset.zero);

    if (itemPosition.dy < screenSize.height) {
      _setVisibility(index);
      setState(() {
        checkIndex++;
      });

      if (checkIndex == widget.items.length) {
        _timer.cancel();
      }
    }
  }

  void _setVisibility(int index) {
    for (int i = 0; i <= index && i < _itemVisibility.length; i++) {
      _itemVisibility[i] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < widget.items.length - 1 ? widget.spacing : 0,
            ),
            child: Align(
              alignment: Alignment.center,
              key: _itemKeys[index],
              child: item,
            )
                .animate(target: _itemVisibility[index] ? 1.0 : 0.0)
                .fadeIn(duration: Duration(milliseconds: 400)),
          );
        }).toList(),
      ),
    );
  }
}
