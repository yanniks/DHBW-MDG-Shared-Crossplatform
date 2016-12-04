//
//  UserDefaults.swift
//  MDG Nienburg
//
//  Created by Yannik Ehlert on 08.10.15.
//  Copyright © 2015 Yannik Ehlert. All rights reserved.
//

import Foundation
#if os(iOS)
    import WatchConnectivity
#endif
    

let def = UserDefaults()
class UserDefaults : Foundation.UserDefaults {
    internal static let def2 = Foundation.UserDefaults(suiteName: "group.dhbwstuttgart")!
    override func set(_ value: Any?, forKey defaultName: String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func set(_ value:Bool, forKey defaultName: String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func set(_ value:Float,forKey defaultName:String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func set(_ value:Int, forKey defaultName:String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func set(_ value:Double, forKey defaultName:String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func set(_ value:URL?, forKey defaultName:String) {
        UserDefaults.def2.set(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func setValue(_ value:Any?,forKey defaultName:String) {
        UserDefaults.def2.setValue(value, forKey: defaultName)
        sendKey(defaultName)
    }
    override func synchronize() -> Bool {
        return UserDefaults.def2.synchronize()
    }
    override func dictionaryRepresentation() -> [String:Any] {
        return UserDefaults.def2.dictionaryRepresentation()
    }
    override func array(forKey defaultName:String) -> [Any]? {
        return UserDefaults.def2.array(forKey: defaultName)
    }
    override func bool(forKey defaultName: String) -> Bool {
        return UserDefaults.def2.bool(forKey: defaultName)
    }
    override func data(forKey defaultName:String) -> Data? {
        return UserDefaults.def2.data(forKey: defaultName)
    }
    override func dictionary(forKey defaultName:String) -> [String:Any]? {
        return UserDefaults.def2.dictionary(forKey: defaultName)
    }
    override func float(forKey defaultName:String) -> Float {
        return UserDefaults.def2.float(forKey: defaultName)
    }
    override func integer(forKey defaultName:String) -> Int {
        return UserDefaults.def2.integer(forKey: defaultName)
    }
    override func object(forKey defaultName:String) -> Any? {
        return UserDefaults.def2.object(forKey: defaultName)
    }
    override func value(forKey defaultName:String) -> Any? {
        return UserDefaults.def2.value(forKey: defaultName)
    }
    override func stringArray(forKey defaultName: String) -> [String]? {
        return UserDefaults.def2.stringArray(forKey: defaultName)
    }
    override func string(forKey defaultName:String) -> String? {
        return UserDefaults.def2.string(forKey: defaultName)
    }
    override func double(forKey defaultName:String) -> Double {
        return UserDefaults.def2.double(forKey: defaultName)
    }
    override func url(forKey defaultName:String) -> URL? {
        return UserDefaults.def2.url(forKey: defaultName)
    }
    override func removeObject(forKey defaultName:String) {
        UserDefaults.def2.removeObject(forKey: defaultName)
        sendKey(defaultName)
    }
    func sendKey(_ defaultName:String) {
        #if os(iOS)
            if #available(iOS 9.0, *) {
                var value: Any = "deleted"
                if UserDefaults.def2.object(forKey: defaultName) != nil {
                    value = UserDefaults.def2.object(forKey: defaultName)!
                }
                WCSession.default().transferUserInfo([defaultName:value])
            }
        #endif
    }
    func sendAllKeys() {
        #if os(iOS)
            if #available(iOS 9.0, *) {
                let uinfo = UserDefaults.def2.dictionaryRepresentation()
                WCSession.default().transferUserInfo(uinfo)
            }
        #endif
    }
}
