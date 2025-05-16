import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _showSuggestions = false;
  List<String> _history = ['Áo sơ mi', 'Laptop Dell', 'Tai nghe Bluetooth'];
  List<String> _topKeywords = ['Giày thể thao', 'Điện thoại', 'Túi xách'];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showSuggestions = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Box
        Container(
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
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        // Gợi ý tìm kiếm & Lịch sử
        if (_showSuggestions)
          Container(
            width: 600,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_history.isNotEmpty) ...[
                  Text('search_history'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                  ..._history.map((h) => ListTile(
                        title: Text(h),
                        onTap: () {
                          _controller.text = h;
                          _focusNode.unfocus(); // Ẩn gợi ý
                        },
                      )),
                  const Divider(),
                ],
                Text('search_top_keywords'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                ..._topKeywords.map((k) => ListTile(
                      title: Text(k),
                      onTap: () {
                        _controller.text = k;
                        _focusNode.unfocus();
                      },
                    )),
              ],
            ),
          ),
      ],
    );
  }
}
