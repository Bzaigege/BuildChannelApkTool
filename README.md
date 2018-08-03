#本工具是基于开源项目walle的自动化脚本


##使用条件

1、适用于windows系统

2、需安装和配置Java环境（自行百度安装）

##使用说明
###1、在channel中配置需打包的渠道id

示例说明:

meituan # 美团
samsungapps #三星
hiapk
anzhi
xiaomi # 小米
91com


###2、在sign目录中配置签名文件信息：

在config.ini文件配置应用签名,同时将签名文件放到该目录下
注意：config.ini配置签名信息时，第一行留一行空白

示例说明：

keyAlias=sg

keyPassword=s123456

storeFile=android.keystore

storePassword=s123456


###3、双击运行start.bat后，拖入需签名包体apk即可

