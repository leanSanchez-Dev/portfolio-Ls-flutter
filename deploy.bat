@echo off
echo Starting deployment process...

echo Step 1: Building Flutter web app...
flutter build web --release

echo Step 2: Deploying to Firebase...
firebase deploy

echo Deployment completed!
pause
