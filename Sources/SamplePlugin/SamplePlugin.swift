import Foundation

@_cdecl("bootPlugin")
public func bootPlugin() {
    SamplePlugin().boot()
}

public class SamplePlugin {
    public func boot() {
        print("example payload")
    }
}

