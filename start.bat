@echo off
title �����ְ�����_V1.0.0
color 03

rem ��ȡ��ǰ�Ĺ�������
@set currentWorkPath=%~dp0
echo ��ǰ�Ĺ���Ŀ¼:
echo\%currentWorkPath%
echo\

rem ������Ҫ�ְ���apk�ļ�
echo �뽫apk�ļ���ק����:
@set /p apkFile=
echo\

rem ��ȡapk�ļ���
for /f "delims=" %%i in ("dir /b %apkFile%") do (
	set apkFileName=%%~ni
)	
echo apk�ļ�����:%apkFileName%
echo\

rem ��ȡǩ���ļ���Ϣ
@CALL %currentWorkPath%sign\readconfig keyAlias keyAliasValue
@CALL %currentWorkPath%sign\readconfig storeFile storeFileValue
@CALL %currentWorkPath%sign\readconfig storePassword storePasswordValue
@CALL %currentWorkPath%sign\readconfig keyPassword keyPasswordValue
echo\

rem ������Ŀ¼,û�оʹ���
set apkoutput=%currentWorkPath%apkoutput
if exist apkoutput (
   @rd /s/q apkoutput
) 
@md apkoutput
@md apkoutput\apks

rem apkִ��ǩ����ʹ��V2ǩ����
@call java -jar %currentWorkPath%lib\apksigner.jar sign --ks %currentWorkPath%sign\%storeFileValue% --ks-key-alias %keyAliasValue% --ks-pass pass:%storePasswordValue%  --key-pass pass:%keyPasswordValue% --out %currentWorkPath%apkoutput\%apkFileName%_sign.apk %apkFile%
if ERRORLEVEL 0 (
	echo ǩ���ɹ�,ǩ������·��:
	echo %currentWorkPath%apkoutput\%apkFileName%_sign.apk
) 
echo\


rem ���apk�����ǩ����ʽ
@call java -jar %currentWorkPath%lib\apksigner.jar verify -v %currentWorkPath%apkoutput\%apkFileName%_sign.apk
echo\

rem ���������ְ�
@call java -jar %currentWorkPath%lib\walle-cli-all.jar batch -f %currentWorkPath%channel %currentWorkPath%apkoutput\%apkFileName%_sign.apk %currentWorkPath%apkoutput\apks

if ERRORLEVEL 0 (
	echo �ְ��ɹ�,����·��:
	echo %currentWorkPath%apkoutput\apks
) 
echo\

pause