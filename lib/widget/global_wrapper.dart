import 'package:flutter/material.dart';
import 'status_bar_widget.dart';

// status_bar_widget 모듈화
class GlobalWrapper extends StatelessWidget {
  final Widget child;
  final bool showStatusBar;
  final bool canPop; // 뒤로가기 활성화 여부

  const GlobalWrapper({
    super.key,
    required this.child,
    this.showStatusBar = true,
    this.canPop = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        body: Column(
          children: [
            if (showStatusBar) const StatusBar(), // 조건부로 StatusBar 표시
            Expanded(child: child), // 메인 화면 내용
          ],
        ),
      ),
    );
  }
}
