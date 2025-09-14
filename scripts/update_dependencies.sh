#!/bin/bash

# Скрипт для обновления зависимостей Flutter проекта
# Автор: AI Assistant
# Дата: 2024-12-19

echo "🚀 Начинаем обновление зависимостей AquaLife..."

# Проверяем наличие Flutter
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter не найден. Установите Flutter и добавьте его в PATH."
    exit 1
fi

# Переходим в директорию проекта
cd "$(dirname "$0")/.."

echo "📦 Очищаем кэш pub..."
flutter pub cache clean

echo "🔄 Получаем зависимости..."
flutter pub get

echo "📊 Проверяем устаревшие зависимости..."
flutter pub outdated

echo "🔧 Запускаем генерацию кода..."
flutter packages pub run build_runner build --delete-conflicting-outputs

echo "✅ Обновление завершено!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Проверьте, что приложение компилируется: flutter build apk --debug"
echo "2. Запустите тесты: flutter test"
echo "3. Проверьте линтер: flutter analyze"
echo ""
echo "🎉 Зависимости успешно обновлены!"