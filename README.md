# zinc
macOS Menu Bar RSYNC / FSEventStream Watch Tool

This simple macOS app watches a directory (and all subdirectories) for changes using FSEventStream. If a change is detected, the changed files are copied to a remote host and path using rsync.

Since this app uses FSEventStream and rsync, and therefore could easily copy massive amounts of files to potentially the wrong place in a horribly embarassing and potentially job-ending way, I cannot be held responsible for your use of it. Feel free to read the hard-won code to learn how to use FSEventStream and perhaps how to call rsync using NSTask. Or even how to get the preference window to work, which was probably more effort than FSEventStream itself. But please don't use this and then blame me when you copy your entire hard drive to the corporate wiki.
