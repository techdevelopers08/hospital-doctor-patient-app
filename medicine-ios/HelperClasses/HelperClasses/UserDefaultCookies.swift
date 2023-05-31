//
//  UserDefault.swift
//  Hive
//
//  Created by Nitish Sharma on 13/09/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import Foundation

extension NSDictionary {
    var id : Int {
        return self["id"] as! Int
    }
    var e_id : Int {
        return self["e_id"] as! Int
    }
    var name : String {
        return self["name"] as! String
    }
    var profileimage : String {
        return self["profile_image"] as! String
    }
    var email : String {
          return self["email"] as! String
      }
    var e_name : String {
        return self["e_name"] as! String
    }
    var date : String {
        return self["dob"] as! String
    }
    var gender : String {
          return self["gender"] as! String
      }
    var e_email : String {
        return self["e_email"] as! String
    }
    var e_number : Int {
          return self["e_number"] as! Int
      }
    var e_password : Int {
        return self["e_password"] as! Int
    }
}

class Cookies {

    class func userInfoSave(dict : [String : Any]? = nil){
        let keyData = NSKeyedArchiver.archivedData(withRootObject: dict as Any)
        UserDefaults.standard.set(keyData, forKey: "userInfoSave")
        UserDefaults.standard.synchronize()
    }

    class func userInfo() -> NSDictionary? {
        if let some =  UserDefaults.standard.object(forKey: "userInfoSave") as? NSData {
            if let dict = NSKeyedUnarchiver.unarchiveObject(with: some as Data) as? NSDictionary {
                return dict
            }
        }
        return nil
    }
    
//    class func userInfoModel() -> UserIncoming.Body? {
//        if let some =  UserDefaults.standard.object(forKey: "userInfoSave") as? NSData {
//            if let dict = NSKeyedUnarchiver.unarchiveObject(with: some as Data) as? NSDictionary {
//                let user = UserIncoming.Body(dict: dict as! [String : Any])
//                return user
//            }
//        }
//        return nil
//    }
    
    class func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: "userInfoSave")
    }
}

var currentAccessToken :String? {
    get {
        return  UserDefaults.standard.currentAccessToken()
    }
    set {
        UserDefaults.standard.currentAccessToken(newValue)
    }
}




extension UserDefaults {

    /// Private key for persisting the active Theme in UserDefaults
    private static let currentAccessTokenKey = "AuthToken"

    /// Retreive theme identifer from UserDefaults
    public func currentAccessToken() -> String? {
        return self.string(forKey: UserDefaults.currentAccessTokenKey)
    }

    /// Save theme identifer to UserDefaults
    public func currentAccessToken(_ identifier: String?) {
        self.set(identifier, forKey: UserDefaults.currentAccessTokenKey)
    }

}



