// 团团 Tuunie 主题
// 暖色粘土风 + 圆角 + 软阴影
import 'package:flutter/material.dart';

class TuunieColors {
  static const Color bg = Color(0xFFFFF8EC);          // 奶油底
  static const Color primary = Color(0xFFFFB7B2);     // 蜜桃
  static const Color primaryDark = Color(0xFFFF8A80); // 深蜜桃 (PTT)
  static const Color lemon = Color(0xFFFFE9A8);       // 柠檬
  static const Color mint = Color(0xFFB5EAD7);        // 薄荷
  static const Color lavender = Color(0xFFC7B8EA);    // 薰衣草
  static const Color sky = Color(0xFFA8DADC);         // 天空蓝
  static const Color text = Color(0xFF5A4A3F);        // 浓咖
  static const Color text2 = Color(0xFFA39589);       // 浅咖
  static const Color shadow = Color(0xFFE8D4B8);      // 暖色阴影
}

class TuunieTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: TuunieColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: TuunieColors.primary,
      primary: TuunieColors.primary,
      background: TuunieColors.bg,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Fredoka', fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontFamily: 'Fredoka', fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontFamily: 'Fredoka', fontWeight: FontWeight.w700, fontSize: 24, color: TuunieColors.text),
      titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: TuunieColors.text),
      bodyLarge: TextStyle(fontWeight: FontWeight.w400, color: TuunieColors.text),
      bodyMedium: TextStyle(color: TuunieColors.text),
      labelSmall: TextStyle(fontWeight: FontWeight.w700, color: TuunieColors.text2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TuunieColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 0,
      ),
    ),
  );
}

// 软阴影
List<BoxShadow> softShadow = [
  BoxShadow(
    color: TuunieColors.shadow.withOpacity(0.5),
    blurRadius: 20,
    offset: const Offset(0, 8),
  ),
];

// 卡片样式
BoxDecoration cardDeco({Color? bg}) => BoxDecoration(
  color: bg ?? Colors.white,
  borderRadius: BorderRadius.circular(24),
  boxShadow: softShadow,
);

