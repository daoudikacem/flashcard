@echo off
echo ========================================
echo بناء تطبيق FlashCard APK (Release)
echo ========================================
echo.

cd /d "%~dp0"

echo ملاحظة: هذا APK محسّن وجاهز للنشر
echo.

echo الخطوة 1: تنظيف المشروع...
call gradlew.bat clean
echo.

echo الخطوة 2: بناء APK (Release)...
call gradlew.bat assembleRelease
echo.

if %errorlevel% neq 0 (
    echo ❌ فشل البناء!
    pause
    exit /b 1
)

echo ========================================
echo ✅ تم بناء APK بنجاح!
echo ========================================
echo.
echo الموقع: app\build\outputs\apk\release\app-release.apk
echo.
pause
