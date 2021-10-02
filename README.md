# Charon

Charon provides a launch platform for dynamic libraries on Mach-O platforms. An 
encrypted library can be embedded into charon's binary, to be decrypted and 
loaded at runtime. 

Full access to the Swift library makes potential expansions like downloading new
binaries or requiring a manually entered decryption key trivial to implement. 


### Usage

Modify Package.swift to point to your plugin to embed:

```
linkerSettings: [
    .unsafeFlags([
                    "-Xlinker", "-sectcreate",
                    "-Xlinker", "__TEXT",
                    "-Xlinker", "__charon",
                    "-Xlinker", ".build/debug/libplugin.dylib" // change me
    ])
]),
```

To use the sample plugin you first need to actually produce the dylib. `swift build` 
won't do this on it's own so you'll need to build the plugin product first.

```
swift buid --product=plugin
swift run xortool .build/debug/libplugin.dylib
swift build --product=charon
swift run charon
```

Note: If the plugin is not behaving as expected (un-xor'd lib running normally, 
etc) you may need to clear your `.build` directory. Sometimes the caching isn't 
very smart.  


### Support

1DJ8kYNsX4EsJi6r2xHNmos8MJLQnuTANC


