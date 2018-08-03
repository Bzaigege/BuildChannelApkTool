@echo off
title 渠道分包工具_V1.0.0
color 03

rem 获取当前的工作环境
@set currentWorkPath=%~dp0
echo 当前的工作目录:
echo\%currentWorkPath%
echo\

rem 输入需要分包的apk文件
echo 请将apk文件拖拽进来:
@set /p apkFile=
echo\

rem 截取apk文件名
for /f "delims=" %%i in ("dir /b %apkFile%") do (
	set apkFileName=%%~ni
)	
echo apk文件名称:%apkFileName%
echo\

rem 获取签名文件信息
@CALL %currentWorkPath%sign\readconfig keyAlias keyAliasValue
@CALL %currentWorkPath%sign\readconfig storeFile storeFileValue
@CALL %currentWorkPath%sign\readconfig storePassword storePasswordValue
@CALL %currentWorkPath%sign\readconfig keyPassword keyPasswordValue
echo\

rem 清空输出目录,没有就创建
set apkoutput=%currentWorkPath%apkoutput
if exist apkoutput (
   @rd /s/q apkoutput
) 
@md apkoutput
@md apkoutput\apks

rem apk执行签名（使用V2签名）
@call java -jar %currentWorkPath%lib\apksigner.jar sign --ks %currentWorkPath%sign\%storeFileValue% --ks-key-alias %keyAliasValue% --ks-pass pass:%storePasswordValue%  --key-pass pass:%keyPasswordValue% --out %currentWorkPath%apkoutput\%apkFileName%_sign.apk %apkFile%
if ERRORLEVEL 0 (
	echo 签名成功,签名包体路径:
	echo %currentWorkPath%apkoutput\%apkFileName%_sign.apk
) 
echo\


rem 检测apk包体的签名方式
@call java -jar %currentWorkPath%lib\apksigner.jar verify -v %currentWorkPath%apkoutput\%apkFileName%_sign.apk
echo\

rem 美团渠道分包
@call java -jar %currentWorkPath%lib\walle-cli-all.jar batch -f %currentWorkPath%channel %currentWorkPath%apkoutput\%apkFileName%_sign.apk %currentWorkPath%apkoutput\apks

if ERRORLEVEL 0 (
	echo 分包成功,包体路径:
	echo %currentWorkPath%apkoutput\apks
) 
echo\

pause