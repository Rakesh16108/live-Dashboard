@echo off
title Dashboard Sync to GitHub
color 0A

echo.
echo =============================================
echo   Collection Dashboard - GitHub Sync
echo =============================================
echo.

:: Git installed hai?
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git install nahi hai!
    echo.
    echo Git download karo: https://git-scm.com/downloads
    echo Install karne ke baad ye script dobara chalao.
    pause
    exit /b 1
)

:: Script ki location = repo folder
cd /d "%~dp0"

:: Git repo hai?
if not exist ".git" (
    echo [ERROR] Ye folder GitHub se connected nahi hai!
    echo.
    echo Pehle GitHub setup karo:
    echo   1. GitHub par repo banao
    echo   2. git clone https://github.com/[username]/[repo].git
    echo   3. Ye script wahi cloned folder mein rakh ke chalao
    pause
    exit /b 1
)

:: data folder check
if not exist "data" mkdir data
echo [OK] data/ folder ready

:: data folder mein CSV files dhundo
echo.
echo Checking data/ folder for CSV files...
dir /b data\*.csv 2>nul
if errorlevel 1 (
    echo [WARNING] data/ folder mein koi CSV file nahi mili!
    echo CSV files data\ folder mein rakhni hain.
)

:: Latest changes pull karo pehle
echo.
echo Pulling latest changes from GitHub...
git pull origin main --rebase 2>nul
echo [OK] Pull done

:: Saari changes stage karo
echo.
echo Staging new/updated files...
git add data\*.csv
git add data\*.CSV
git add index.json 2>nul

:: Check karo kuch naya hai ya nahi
git diff --staged --quiet
if errorlevel 1 (
    :: Timestamp ke saath commit message
    for /f "tokens=1-5 delims=/ " %%a in ('date /t') do set mydate=%%c-%%b-%%a
    for /f "tokens=1-2 delims=: " %%a in ('time /t') do set mytime=%%a:%%b

    git commit -m "📊 Data update — %mydate% %mytime%"

    echo.
    echo Pushing to GitHub...
    git push origin main

    if errorlevel 1 (
        echo.
        echo [ERROR] Push failed! GitHub credentials check karo.
        echo.
        echo Fix: git config --global credential.helper manager
        pause
        exit /b 1
    )

    echo.
    echo =============================================
    echo  SUCCESS! Data GitHub par push ho gaya!
    echo  Dashboard 1-2 min mein update ho jayega.
    echo =============================================
) else (
    echo.
    echo [INFO] Koi naya CSV nahi mila — kuch change nahi hua.
    echo  Naya CSV file data\ folder mein rakhkar dobara chalao.
)

echo.
pause
