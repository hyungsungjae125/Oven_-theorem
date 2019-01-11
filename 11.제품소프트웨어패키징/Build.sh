#!/bin/sh
###############################################################
# Service > systemd > dotnet.service
# Sample Project > /root
# ip Change > 192.168.3."You linux ip"
# MariaDB > user(root)/password(test) > table(test.board)
###############################################################
gitPath=https://github.com/hyungsungjae125/Project.git
rootDir=/var/lib/jenkins/workspace/Test
projectDir=/Project
publishDir=/Project/bin/Debug/netcoreapp2.1/publish
serviceDir=/publish

#1 빌드 대상 프로젝트 경로 확인
if [ -d $rootDir$projectDir ]; then
  rm -Rf $rootDir$projectDir
fi
# 1. GitHub Repository Download
git clone $gitPath
cd $rootDir$projectDir

# 2. Project Build
dotnet build


# 3. Service Shutdown
systemctl stop dotnet.service

# 4. Project Publish
dotnet publish
ln -s $rootDir$publishDir $rootDir$serviceDir

# 5. Service Run
systemctl start dotnet.service
###############################################################
exit 0

