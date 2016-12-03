//
//  mdg-crypto.swift
//  MDG Nienburg
//
//  Created by Yannik Ehlert on 03.11.14.
//  Copyright (c) 2014 Yannik Ehlert. All rights reserved.
//

import UIKit
import SystemConfiguration

public enum IJReachabilityType {
    case wwan,
    wiFi,
    notConnected
}

extension String {
    
    func hmac(_ algorithm: HMACAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength()
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let objcKey = key as NSString
        let keyStr = objcKey.cString(using: String.Encoding.utf8.rawValue)
        let keyLen = Int(objcKey.lengthOfBytes(using: String.Encoding.utf8.rawValue))
        
        CCHmac(algorithm.toCCHmacAlgorithm(), keyStr, keyLen, str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return hash as String
    }
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return (output as NSString) as String
    }
}
func gencode(_ str:String?=nil) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "Europe/Berlin")
    formatter.dateFormat = "yyyyMMdd"
    var vplanstring = ""
    if str == nil {
        if let vplan = def.object(forKey: "vplanlink") as? String {
            vplanstring = vplan
        }
    } else {
        vplanstring = str!
    }
    let cdat = formatter.string(from: Date()) + vplanstring
    let token = cdat.hmac(HMACAlgorithm.sha512,key: "Te7>Ux?Gx8+wpdKNyqjF9(")
    return token
}
enum HMACAlgorithm {
    case md5, sha1, sha224, sha256, sha384, sha512
    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .md5:
            result = kCCHmacAlgMD5
        case .sha1:
            result = kCCHmacAlgSHA1
        case .sha224:
            result = kCCHmacAlgSHA224
        case .sha256:
            result = kCCHmacAlgSHA256
        case .sha384:
            result = kCCHmacAlgSHA384
        case .sha512:
            result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
        case .md5:
            result = CC_MD5_DIGEST_LENGTH
        case .sha1:
            result = CC_SHA1_DIGEST_LENGTH
        case .sha224:
            result = CC_SHA224_DIGEST_LENGTH
        case .sha256:
            result = CC_SHA256_DIGEST_LENGTH
        case .sha384:
            result = CC_SHA384_DIGEST_LENGTH
        case .sha512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}
func isConnectedToNetworkOfType() -> IJReachabilityType {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags(rawValue: 0)
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return .notConnected
    }
    
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let isWWAN = (flags.rawValue & UInt32(1<<18)) != 0
    
    if(isReachable && isWWAN){
        return .wwan
    }
    if(isReachable && !isWWAN){
        return .wiFi
    }
    
    return .notConnected
}
