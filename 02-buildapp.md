# Hello World App

Build a basic Hello World App and compile it using the SDK setup.

This list is based on an [updated answer][v2a] from StackOverflow
which replaces Jill and Jack with `dx`.

## Prerequisites

 - SDK and tools developed from [the previous file][env]
 - Java 1.8
 - Linux

## Procedure

  1. Create an empty directory for the code, then enter it.

         mkdir helloworld
         cd helloworld

  2. Set up the directory tree as Java expects.

         mkdir -p src/com/domain

  3. Edit the source file, or just use the one in the repo:

         $EDITOR src/com/domain/helloworld.java

  4. Add an `AndroidManifest.xml`:

         $EDITOR AndroidManifest.xml

  5. Create an empty `res` directory for later:

         mkdir res

  6. If `res/` is not empty in future, prepare it for use:

         aapt package -f \
                      -I $SDK/platforms/$ANDROID_API/android.jar \
                      -J src \
                      -m \
                      -M AndroidManifest.xml \
                      -S res \
                      -v

  7. Compile the bytecode (`.class`) from source:

         javac -bootclasspath $SDK/platforms/$ANDROID_API/android.jar \
               -classpath src \
               -source 1.8 \
               -target 1.8 \
               src/com/domain/helloworld.java

  8. Use `dx` instead of Jill/Jack to convert `.class` to `dex`.

         dx --dex --output="classes.dex" src

  9. Repackage the resources with the manifest into apkPart:

         aapt package -f \
                      -F app.apkPart \
                      -I $SDK/platforms/$ANDROID_API/android.jar \
                      -M AndroidManifest.xml \
                      -S res \
                      -v

  10. Now build the APK from the apkPart:

          CLASSPATH=$SDK/tools/lib/* java com.android.sdklib.build.ApkBuilderMain app.apkUnalign \
                                         -d \
                                         -f classes.dex \
                                         -v \
                                         -z app.apkPart

  11. Align the APK:

           zipalign -f -v 4 app.apkUnalign app.apk

  12. With an Android device connected, install and run the APK:

           adb install -r app.apk
           adb shell am start -n com.domain/.helloworld

## Note

- As this is Java, make sure the file name and class name match.
- Be sure to check the AndroidManifest.xml for sanity as well.

[env]: 01-environment.md
[v2a]: https://stackoverflow.com/a/49377067
