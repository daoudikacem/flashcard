@echo off
echo ========================================
echo بناء تطبيق FlashCard APK
echo ========================================
echo.

cd /d "%~dp0"

echo الخطوة 1: التحقق من Java...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ خطأ: Java غير مثبت!
    echo حمل Java JDK 17 من: https://adoptium.net/
    pause
    exit /b 1
)
echo ✅ Java مثبت
echo.

echo الخطوة 2: تنظيف المشروع...
call gradlew.bat clean
echo.

echo الخطوة 3: بناء APK (Debug)...
call gradlew.bat assembleDebug
echo.

if %errorlevel% neq 0 (
    echo ❌ فشل البناء!
    echo تحقق من الأخطاء أعلاه
    pause
    exit /b 1
)

echo ========================================
echo ✅ تم بناء APK بنجاح!
echo ========================================
echo.
echo الموقع: app\build\outputs\apk\debug\app-debug.apk
echo.
echo هل تريد فتح المجلد؟ (Y/N)
set /p openFolder=

if /i "%openFolder%"=="Y" (
    explorer app\build\outputs\apk\debug\
)

echo.
pause
