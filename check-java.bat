@echo off
echo ===================================
echo التحقق من تثبيت Java
echo ===================================
echo.

java -version

if %errorlevel% neq 0 (
    echo.
    echo ❌ Java no
    echo.
    echo قم بتحميل Java JDK 17 من:
    echo https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
    echo.
    echo أو استخدم OpenJDK:
    echo https://adoptium.net/
    echo.
    pause
    exit /b 1
)

echo.
echo ✅ Java oui
echo.
pause
