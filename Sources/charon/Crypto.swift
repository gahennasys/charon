import Foundation


protocol Encryptor {
    func encrypt(_ data: Data) -> Data
}


protocol Decryptor {
    func decrypt(_ data: Data) -> Data
}


class XORCryptor: Encryptor, Decryptor {

    func encrypt(_ data: Data) -> Data {
        return decrypt(data)
    }


    func decrypt(_ ctext: Data) -> Data {
        var decrypted = Data(ctext)
        let key = UInt8( ctext.count % Int(UInt8.max) )

        for i in 0..<ctext.count {
            decrypted[i] = ctext[i] ^ key
        }

        return decrypted
    }
}
