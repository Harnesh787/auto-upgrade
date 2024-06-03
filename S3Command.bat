@echo off

REM Define S3 bucket URLs
set main_script_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/MainScript.bat
set step1_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step1_CreateAutoDeployFolder.bat
set step2_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step2_DownloadBestool.bat
set step3_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step3_DownloadCentral.bat
set step4_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step4_DownloadWeb.bat
set step5_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step5_DeleteOldServers.bat
set step6_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step6_RunBackup.bat
set step7_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step7_InstallDependencies.bat
set step8_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step8_CopyLocalJson.bat
set step9_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step9_RunDatabaseMigrations.bat
set step10_url=https://bes-tamanu-release-clients.s3.ap-southeast-2.amazonaws.com/tamanuupgrade/Step10_StartApplicationWithPM2.bat

REM Create AutoDeploy directory if it doesn't exist
mkdir C:\AutoDeploy 2>nul

REM Download all necessary files from the S3 bucket to the AutoDeploy directory
echo Downloading MainScript.bat...
powershell -Command "Invoke-WebRequest -Uri '%main_script_url%' -OutFile 'C:\AutoDeploy\MainScript.bat'"
echo Downloading Step1_CreateAutoDeployFolder.bat...
powershell -Command "Invoke-WebRequest -Uri '%step1_url%' -OutFile 'C:\AutoDeploy\Step1_CreateAutoDeployFolder.bat'"
echo Downloading Step2_DownloadBestool.bat...
powershell -Command "Invoke-WebRequest -Uri '%step2_url%' -OutFile 'C:\AutoDeploy\Step2_DownloadBestool.bat'"
echo Downloading Step3_DownloadCentral.bat...
powershell -Command "Invoke-WebRequest -Uri '%step3_url%' -OutFile 'C:\AutoDeploy\Step3_DownloadCentral.bat'"
echo Downloading Step4_DownloadWeb.bat...
powershell -Command "Invoke-WebRequest -Uri '%step4_url%' -OutFile 'C:\AutoDeploy\Step4_DownloadWeb.bat'"
echo Downloading Step5_DeleteOldServers.bat...
powershell -Command "Invoke-WebRequest -Uri '%step5_url%' -OutFile 'C:\AutoDeploy\Step5_DeleteOldServers.bat'"
echo Downloading Step6_RunBackup.bat...
powershell -Command "Invoke-WebRequest -Uri '%step6_url%' -OutFile 'C:\AutoDeploy\Step6_RunBackup.bat'"
echo Downloading Step7_InstallDependencies.bat...
powershell -Command "Invoke-WebRequest -Uri '%step7_url%' -OutFile 'C:\AutoDeploy\Step7_InstallDependencies.bat'"
echo Downloading Step8_CopyLocalJson.bat...
powershell -Command "Invoke-WebRequest -Uri '%step8_url%' -OutFile 'C:\AutoDeploy\Step8_CopyLocalJson.bat'"
echo Downloading Step9_RunDatabaseMigrations.bat...
powershell -Command "Invoke-WebRequest -Uri '%step9_url%' -OutFile 'C:\AutoDeploy\Step9_RunDatabaseMigrations.bat'"
echo Downloading Step10_StartApplicationWithPM2.bat...
powershell -Command "Invoke-WebRequest -Uri '%step10_url%' -OutFile 'C:\AutoDeploy\Step10_StartApplicationWithPM2.bat'"

REM Check if any download failed
if %errorlevel% neq 0 (
    echo Error: Failed to download files from S3 bucket.
    exit /b 1
)

REM Define variables
set /p platform="Enter platform: "
set /p version="Enter version: "
set /p old_server="Enter old server version: "
set /p new_server="Enter new server version: "

REM Execute the script with defined variables
cd /d C:\AutoDeploy
call MainScript.bat %platform% %version% %old_server% %new_server%
