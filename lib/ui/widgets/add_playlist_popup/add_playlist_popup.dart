import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/add_playlist_popup/add_playlist_widget.dart';

void showAddPlaylistPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5), // Làm tối nền
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Làm mờ nền
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16), // Khoảng cách popup với viền màn hình
          child: AddPlaylistWidget(), // Hiển thị widget đã custom
        ),
      );
    },
  );
}
