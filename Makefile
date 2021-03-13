# Makefile for building a full aligned debugging APK 

SDK = $$HOME/AndroidSDK
API_VERSION = android-30
ANDROID_JAR = ${SDK}/platforms/${API_VERSION}/android.jar
JDK_VERSION = 1.8
SRC_PATH = src/com/icedwater/*.java

all: res dex alignapk

clean:
	rm classes.dex
	rm app.*

test:
	echo ${ANDROID_JAR}

resource: res
	aapt package -f -I ${ANDROID_JAR} -J src -m -M AndroidManifest.xml -S res -v

class: src
	javac -bootclasspath ${ANDROID_JAR} -classpath src -source ${JDK_VERSION} -target ${JDK_VERSION} ${SRC_PATH}

apkpart:
	aapt package -f -F app.apkPart -I ${ANDROID_JAR} -M AndroidManifest.xml -S res -v

dex: class
	dx --dex --output="classes.dex" src

buildapk: apkpart app.apkPart
	CLASSPATH=${SDK}/tools/lib/* java com.android.sdklib.build.ApkBuilderMain app.apkUnalign \
        -d -f classes.dex -v -z app.apkPart

alignapk: buildapk app.apkUnalign
	zipalign -f -v 4 app.apkUnalign app.apk

install: alignapk app.apk
	adb install -r app.apk
