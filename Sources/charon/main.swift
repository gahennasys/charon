import Foundation


let loader = Loader()
let crypto = XORCryptor()

if let embedded = loader.extractPlugin() {
    //  If your embedded plugin is encrypted:
    let plugin = crypto.decrypt(embedded)
    loader.loadPlugin(plugin)
}

