@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
TITLE Git Uploader by BUNNY0417 -  Git Push Script

:: =====================================================
echo ====================================================
echo    G I T   U P L O A D E R   B A T   S C R I P T
echo                 by BUNNY0417
echo ====================================================
echo.

:: ---------- Logging Setup ----------
set "logFile=%~dp0git_uploader.log"
echo [%DATE% %TIME%] Script started by BUNNY0417. >> "%logFile%"

:: ---------- Welcome ----------
echo Welcome to the Enhanced Git Uploader by BUNNY0417!
echo.
echo Press any key to continue or Ctrl+C to cancel...
pause >nul

:: ---------- Check Git ----------
git --version >nul 2>&1
if ERRORLEVEL 1 (
    echo ERROR: Git not found. Please install Git: https://git-scm.com/
    pause
    exit /b 1
)
echo Git detected: %git --version% 2>&1

:: ---------- Get Folder Path ----------
echo.
color 0A
set /p "repoDir=Enter the full path of the folder to upload: "
color 07
if "%repoDir%"=="" (
    echo ERROR: No directory entered.
    pause
    exit /b 1
)
if not exist "%repoDir%" (
    echo ERROR: Directory "%repoDir%" does not exist.
    pause
    exit /b 1
)
cd /d "%repoDir%"
echo [%DATE% %TIME%] Working directory set to %repoDir% >> "%logFile%"

:: ---------- Branch Selection ----------
echo.
color 0A
set /p "targetBranch=Enter branch name to push [default: main]: "
color 07
if "%targetBranch%"=="" set "targetBranch=main"
echo Using branch: %targetBranch%

:: ---------- .gitignore Option ----------
echo.
color 0A
set /p "createIgnore=Create a basic .gitignore in this folder? (y/N): "
color 07
if /i "%createIgnore%"=="y" (
    if not exist .gitignore (
        > .gitignore (
            echo # Compiled source
            echo *.com
            echo *.class
            echo *.dll
            echo *.exe
            echo *.o
        )
        echo .gitignore created.
        echo [%DATE% %TIME%] .gitignore generated. >> "%logFile%"
    ) else (
        echo .gitignore already exists; skipping.
    )
)

:: ---------- Initialize or Verify Repo ----------
echo.
if not exist ".git" (
    echo Initializing new Git repository...
    git init >> "%logFile%" 2>&1
) else (
    echo Existing Git repository detected.
)

:: ---------- Get Remote URL ----------
echo.
color 0A
set /p "repoURL=Enter the Git repo SSH/HTTPS URL: "
color 07
if "%repoURL%"=="" (
    echo ERROR: Repository URL cannot be empty.
    pause
    exit /b 1
)
git remote remove origin >nul 2>&1
git remote add origin "%repoURL%"
echo [%DATE% %TIME%] Remote set to %repoURL% >> "%logFile%"

:: ---------- Pull Latest ----------
echo.
echo Pulling latest changes from origin/%targetBranch%...
git fetch origin "%targetBranch%" >> "%logFile%" 2>&1
git checkout "%targetBranch%" 2>> "%logFile%" || git checkout -b "%targetBranch%"
git pull origin "%targetBranch%" --rebase >> "%logFile%" 2>&1

:: ---------- Stage Files ----------
echo.
echo Staging all files...
git add . >> "%logFile%" 2>&1

:: ---------- Commit ----------
echo.
color 0A
set /p "commitMsg=Enter commit message [Default: Add all files]: "
color 07
if "%commitMsg%"=="" set "commitMsg=Add all files"
echo Committing: "%commitMsg%"
git commit -m "%commitMsg%" >> "%logFile%" 2>&1

:: ---------- Push ----------
echo.
echo Pushing to %targetBranch%...
git push -u origin "%targetBranch%" >> "%logFile%" 2>&1

:: ---------- Finish ----------
echo.
echo SUCCESS: Files uploaded to %repoURL% on branch '%targetBranch%'.
echo Log saved to %logFile%
echo.
pause
ENDLOCAL
