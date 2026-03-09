@echo off
:: Variables
set LOG_DIR=C:\path\to\your\logs
set BACKUP_DIR=C:\temp\log_backups
set BUCKET_NAME=my-app-logs-backup
set DATE=%date:~10,4%-%date:~4,2%-%date:~7,2%-%time:~0,2%%time:~3,2%
set ARCHIVE_NAME=logs-%DATE: =0%.zip

:: 1. Create a temporary staging area
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: 2. Compress the logs
:: Windows 10/11 has 'tar' built-in. 
tar -czf "%BACKUP_DIR%\%ARCHIVE_NAME%" -C "%LOG_DIR%" .

:: 3. Push to S3
aws s3 cp "%BACKUP_DIR%\%ARCHIVE_NAME%" "s3://%BUCKET_NAME%/"

:: 4. Cleanup local temp files
del /f /q "%BACKUP_DIR%\%ARCHIVE_NAME%"

:: 5. Cleanup original logs older than 7 days
forfiles /p "%LOG_DIR%" /m *.log /d -7 /c "cmd /c del @path"

echo Backup Complete!
pause