import Foundation
import MachO


class Loader {

    func loadPlugin(_ pluginData: Data) {

        let uuid = UUID().uuidString
        let path = "\(NSTemporaryDirectory())\(uuid)"

        do {
            let targetFile = URL(fileURLWithPath: path)
            try pluginData.write(to: targetFile, options: [.atomicWrite])
        } catch {
            print("Plugin cache failed")
            return
        }

        if let plugin = dlopen(path, RTLD_LAZY)  {
            defer {
                dlclose(plugin)
            }
            let symbolName = "bootPlugin"
            let sym = dlsym(plugin, symbolName)

            if sym != nil {
                let boot: BootPlugin = unsafeBitCast(sym, to: BootPlugin.self)
                boot()
            } else {
                print("Plugin boot failed")
            }
        } else {
            print("Plugin load failed")
        }
    }


    @discardableResult func extractPlugin() -> Data? {

        if let handle = dlopen(nil, RTLD_LAZY) {
            defer { dlclose(handle) }

            if let ptr = dlsym(handle, MH_EXECUTE_SYM) {
                let mhExecHeaderPtr = ptr.assumingMemoryBound(to: mach_header_64.self)

                var size: UInt = 0
                let pluginPtr = getsectiondata(
                    mhExecHeaderPtr,
                    "__TEXT",
                    "__charon",
                    &size)

                let pluginLength = Int(size)

                let plugin = Data(bytes: pluginPtr!, count: pluginLength)
                return plugin
            }
        }

        return nil
    }

}
