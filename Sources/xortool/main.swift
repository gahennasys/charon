import Foundation

// lazy copy paste to avoid dupe symbols
func encrypt(_ plaintext: Data) -> Data {
    var encrypted = Data(plaintext)
    let key = UInt8( plaintext.count % Int(UInt8.max) )

    for i in 0..<plaintext.count {
        encrypted[i] = plaintext[i] ^ key
    }

    return encrypted
}


if CommandLine.argc < 2 {
    fatalError("enter a filename in the current directory")
}


let filename = CommandLine.arguments[1]
print(filename)

let path = "\(Process().currentDirectoryPath)/\(filename)"

print("encrypting: \(path)")


do {
    let targetFile = URL(fileURLWithPath: path)

    let orig = try Data(contentsOf: targetFile)

    let crypt = encrypt(orig)
    try crypt.write(to: targetFile)
} catch {
    print("failed: \(error)")
}


