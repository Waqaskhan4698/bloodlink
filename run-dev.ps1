# BloodLink Development Server Startup Script
# یہ script Node.js کو PATH میں شامل کرتا ہے اور دونوں servers چلاتا ہے

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "BloodLink Development Environment" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Node.js کو PATH میں شامل کریں
$env:Path = 'C:\Program Files\nodejs;' + $env:Path

# تصدیق کریں کہ npm موجود ہے
Write-Host "`n✓ Node.js Path شامل کیا گیا..." -ForegroundColor Green
& 'C:\Program Files\nodejs\node.exe' --version
& 'C:\Program Files\nodejs\npm.cmd' --version

# دونوں servers کے لیے دو علیحدہ PowerShell processes کھولیں
Write-Host "`n🚀 Backend server شروع ہو رہا ہے (Port 5000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "`$env:Path = 'C:\Program Files\nodejs;' + `$env:Path; cd '$PSScriptRoot\backend'; & 'C:\Program Files\nodejs\node.exe' server.js"
)

Start-Sleep -Seconds 3

Write-Host "🚀 Frontend server شروع ہو رہا ہے (Port 3000)..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "`$env:Path = 'C:\Program Files\nodejs;' + `$env:Path; cd '$PSScriptRoot\frontend'; & 'C:\Program Files\nodejs\npm.cmd' start"
)

Write-Host "`n✓ دونوں servers شروع ہو رہے ہیں!" -ForegroundColor Green
Write-Host "  Backend: http://localhost:5000" -ForegroundColor Cyan
Write-Host "  Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "`n(یہ window کو بند نہ کریں - یہ servers کو manage کر رہی ہے)" -ForegroundColor Yellow
