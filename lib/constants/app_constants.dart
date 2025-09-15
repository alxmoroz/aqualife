// Copyright (c) 2021. Alexandr Moroz

/// Константы приложения
class AppConstants {
  // Приватный конструктор для предотвращения создания экземпляров
  AppConstants._();

  /// UI константы
  static const double sidePadding = 12.0;
  static const double cardPadding = 10.0;
  static const double tabletCardPadding = 20.0;

  /// Константы для расчета дневной нормы воды
  static const int defaultUserWeight = 70; // кг
  static const int mlPerKg = 35; // мл на кг веса тела

  /// Константы для валидации
  static const int minQuantity = 0;
  static const int maxQuantity = 9999;

  /// Константы для уведомлений
  static const String notificationThreadId = 'aqualife';
  
  /// Времена уведомлений (часы)
  static const List<int> notificationHours = [9, 11, 13, 15, 17, 19, 21];
  static const int notificationMinutes = 2;

  /// Коды жидкостей
  static const String defaultLiquidCode = 'water';
}