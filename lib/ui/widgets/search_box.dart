import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<String> _history = [];
  List<String> _topKeywords = ['Maroon 5', 'Taylor Swift', 'Red Velvet', 'Sugar', 'Maps', 'Shake It Off', 'ກັບບໍ່ໄດ້'];

  final GlobalKey _boxKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) return; // tránh hiện lại nhiều lần

    final RenderBox renderBox = _boxKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 4,
        width: size.width,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_history.isNotEmpty) ...[
                  const Text("🔁 Lịch sử tìm kiếm", style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._history.map((h) => ListTile(
                        title: Text(h,
                            style: const TextStyle(color: Color(0xFF333333))),
                        onTap: () {
                          _controller.text = h;
                          _focusNode.unfocus(); // Ẩn gợi ý
                        },
                      )),
                  const Divider(),
                ],
                Text('top_keywords'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                ..._topKeywords.map((k) => ListTile(
                      title: Text(k,
                      style: const TextStyle(color: Color(0xFF333333))),
                      onTap: () {
                        _controller.text = k;
                        _focusNode.unfocus();
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _boxKey,
      width: 600,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF9E9E9E)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Search (Ctrl+/)',
                hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: (query) {
    if (_controller.text.trim().isNotEmpty) {
      Get.toNamed('/results', arguments: {'query': _controller.text.trim()});
    }
  },
            ),
          ),
        ],
      ),
    );
  }
}
