//
//  LeoSwiftCoder.swift
//  Apex
//
//  Created by tecH on 05/02/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation

//let coder = LeoSwiftCoder()
//coder.leoClassMake(withName: "LogIn", json: json)
//print("fgff")

extension StringProtocol {
    var firstUppercasedLSC : String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalizedLSC: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
    
    var unCapitalizedLSC: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
}
class LeoSwiftCoder {
    
    func leoClassMake(withName : String , json :Any) {
        switch json.self {
        case is [String : Any] :
            
            if let someJson = json as? [String : Any] {
                print("class \(withName) {")
                print("var serverData : [String: Any] = [:]")
                for key in someJson.keys {
                  
                    let type = self.typeOf(send: someJson[key]! , key : key)
                    
                    if type == "[Bool]" {
                        
                    print( "var \(key.unCapitalizedLSC) : \(type)? = []" )
                    }else if  type == "[Int]" {
                    
                        print( "var \(key.unCapitalizedLSC) : \(type)? = [] " )
                    }else if  type == "[String]" {
                        
                        print( "var \(key.unCapitalizedLSC) : \(type)? = [] " )
                    }else {
                        
                        print( "var \(key.unCapitalizedLSC) : \(type)?" )
                    }
                    
                
                }
                print("init(dict: [String: Any]){")
                print(" self.serverData = dict \n ")
                
                for key in someJson.keys {
                    print( self.defineVariable(key :key , send: someJson[key]!) )
                    
                }
                print("}")
             
                for object in someJson.keys {
                    if let nextObject = someJson[object] as? [String : Any] {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    } else if let nextObject = someJson[object] as? [[String : Any]] {
                        if nextObject.count > 0 {
                            self.leoClassMake(withName: object.capitalized, json: nextObject.first!)
                        }
                    }else if let nextObject = someJson[object] as? Array<String> {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    }
                    else if let nextObject = someJson[object] as? Array<Int> {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    }else if let nextObject = someJson[object] as? Array<Bool> {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    }
                    
                }
                   print("}")
            }
            
        case is Array<String> :
           if let someJson = json as? [String] {
            if someJson.count > 0 {
                print("class \(withName) {")
                print("var serverData : [String] = []")
                
                print("init(dict: [String]){")
                print(" self.serverData = dict \n ")
                
                
                print("}")
                print("}")
            }
           }
        case is Array<Int> :
            if let someJson = json as? [Int] {
                if someJson.count > 0 {
                    print("class \(withName) {")
                    print("var serverData : [Int] = []")
                    print("init(dict: [Int] ){")
                    print(" self.serverData = dict \n ")
                    print("}")
                    print("}")
                }
            }
        case is Array<Bool> :
            if let someJson = json as? [Bool] {
                if someJson.count > 0 {
                    print("class \(withName) {")
                    print("var serverData : [Bool] = []")
                    print("init(dict: [Bool] ){")
                    print(" self.serverData = dict \n ")
                    print("}")
                    print("}")
                }
            }
        case is Int :
            print("")
            
            
            
        case is Array<Any> :
            print("")
            
            
            
            
        case is Dictionary<String, Any> :
            print("")
        case is Bool :
            print("")
        case is String :
            print("")
            
        default:
            print("")
        }
        
    }
    
    private   func defineVariable(key :String, send :Any) -> String{
        switch send.self {
        case is [String : Any] :
            
            let some =  """
            if let object = dict[\"\(key)\"] as? [String : Any] {
            let some =  \(key.capitalized)(dict: object)
            self.\(key.unCapitalizedLSC) = some }
            """
            
            return  some
            
        //"if let \(key) = dict[\"\(key)\"] as? \(key.capitalized) { \n self.\(key) = \(key) \n }"
        case is [[String : Any]] :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [[String : Any]] {
            self.\(key.unCapitalizedLSC) = []
            for object in \(key.unCapitalizedLSC) {
            let some =  \(key.capitalized)(dict: object)
            self.\(key.unCapitalizedLSC)?.append(some)
            
            }
            }
            """
            return  some
        case is Int :
            return "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Int { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is Array<String>  :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [String] {
            self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC)
            }
            """
            return  some
        case is Array<Int>  :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [Int] {
            self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC)
            }
            """
            return  some
        case is Array<Bool>  :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [Bool] {
            self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC)
            }
            """
            return  some
            
            
        case is Array<Any> :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Array<Any> { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is Dictionary<String, Any> :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as?  Dictionary<String, Any> { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is Bool :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Bool { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is String :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? String { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
            
        default:
            return "Any"
        }
    }
    private  func typeOf(send :Any , key : String? = nil ) -> String{
        switch send.self {
        case is [String : Any] :
            if (key != nil) {
                return "\(key!.capitalized)"
            } else {
                return "[String : Any]"
            }
        case is [[String : Any]] :
            if (key != nil) {
                return "[\(key!.capitalized)]"
            } else {
                return "[[String : Any]]"
            }
        case is Array<String> :
             return "[String]"
        case is Array<Int> :
            return "[Int]"
        case is Array<Bool> :
            return "[Bool]"
        case is [[String]] :
            return "[[String]]"
        case is [[Bool]] :
           return "[[Bool]]"
        case is [[Int]] :
            return "[[Int]]"
        case is Int :
            return "Int"
        case is Array<Any> :
            return "Array<Any>"
        case is Dictionary<String, Any> :
            return "Dictionary<String, Any>"
        case is Bool :
            return "Bool"
        case is String :
            return "String"
            
        default:
            return "Any"
        }
        
    }
    
}

