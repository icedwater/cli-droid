# Building an Android App from CLI

This is based on [this answer][ans] on StackOverflow, though since 2017,
quite a few things have changed, such as the command-line tools.

The `.gitignore` was based on [this project][nub].

## Prerequisites

  1. Create a directory to set up SDKs in.

         mkdir $SDK  # e.g. $HOME/AndroidSDK

  2. Download the [command-line tools][cli] from the Android
     Developers site, then unzip it to a directory you like.
     Change into that directory.

         unzip $CLI_TOOLS   # e.g. $HOME/Downloads
         cd cmdline-tools/

  3. Run the SDK manager to get an updated list of packages.

         bin/sdkmanager --sdk_root=$SDK --list

  4. Install the command-line tools package.

         bin/sdkmanager --sdk_root=$SDK --install "cmdline-tools;3.0"

     This puts a fresh cmdline-tools into `$SDK` so we
     won't need to keep specifying `--sdk_root` from now on.
     Change to the `$SDK` directory and use the tools there.

         cd $SDK/cmdline-tools/3.0
         bin/sdkmanager --list  # much easier now

  5. Install the platform tools, then a toolkit for an Android
     version of your choice, e.g. 30.0.3:

         bin/sdkmanager --install "platform-tools"
         bin/sdkmanager --install "build-tools;30.0.3"
         bin/sdkmanager --install "platforms;android-30"
         bin/sdkmanager --install "system-images;android-30;google_apis;x86_64"

     If you re-run `bin/sdkmanager --list`, you should now see
     that `emulator` and `patcher;v4` are also installed.

  6. Now append `$SDK` to the environment variable `$PATH`.

         export PATH=$PATH:$SDK;    # assuming bash

     You may want to add this to the bottom of `.profile` so it
     is updated every time you log in.

  7. We're now at the optional step 2 of the [answer][ans], adding
     directories to the $PATH:

       - `$SDK/platform-tools`
       - `$SDK/tools`
       - `$SDK/build-tools/30.0.3`

  I chose to also add the `bin/` subdirectories, not sure if it
     complicates things down the road:

       - `$SDK/platform-tools/bin`
       - `$SDK/tools/bin`
       - `$SDK/build-tools/30.0.3/bin`

   This, hopefully, just drops `bin/` from future executable calls.
   You may have to log out and back in if you set `$PATH` via `.profile`.

[ans]: https://stackoverflow.com/a/29313378
[nub]: https://github.com/pubnub/java/blob/master/.gitignore
[cli]: https://developer.android.com/studio#command-tools
