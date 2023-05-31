//
//  WebServices.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//
/*
 Basic Auth with Parameters
 Auth Token with Parameters
 Simple Post or Get
 Single Upload
 Multiple Upload
 */
import Foundation
import Alamofire
typealias CompletionBlock = ([String : Any]) -> Void
typealias FailureBlock = ([String : Any]) -> Void
typealias ProgressBlock = (Double) -> Void


// ((Swift.Int) -> Swift.Void)? = nil )
// http://fuckingswiftblocksyntax.com
/// https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started
func isConnectedToInternet() ->Bool {
    return NetworkReachabilityManager()!.isReachable
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
class WebServices {
    
    enum ContentType : String {
        case applicationJson = "application/json"
        case textPlain = "text/plain"
        case form = "application/x-www-form-urlencoded"
    }
    
    static var manager = Alamofire.SessionManager.default
    class func postAuth( url : Api,
                         parameters  : [String : Any]  ,
                         method : HTTPMethod? = .post ,
                         contentType: ContentType? = .applicationJson,
                         authorization : (user: String, password: String)? = nil,
                         authorizationToken : Bool?  = nil,refreshToken : Bool?  = nil,
                         completionHandler: CompletionBlock? = nil,
                         failureHandler: FailureBlock? = nil){
        var headers : HTTPHeaders = [
            "Content-Type": contentType!.rawValue,
            "cache-control": "no-cache"//,
//            "username" : "ajay1@marketsflow.com",
//            "password" : "UKengland10"
            ]
        
        
        if contentType! == .applicationJson {
            if authorization != nil {
                if let authorization1 = authorization {
                    if let authorizationHeader = Request.authorizationHeader(user: authorization1.user, password: authorization1.password) {
                        headers[authorizationHeader.key] = authorizationHeader.value
                    }
                }
            }
        }
//        if let token = authorizationToken {
//            headers["Authorization"] = "Bearer \(token)"
//        }
        if refreshToken == true{
            headers["Authorization"] = "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKey.kUserRefreshToken) ?? "")"
        }else{
            if authorizationToken == true{
                headers["Authorization"] = "Bearer \(UserDefaults.standard.value(forKey: UserDefaultKey.kUserToken) ?? "")"
            }
        }
        
        
        
        let urlString = url.baseURl()
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        var somString = ""
        
        let dictionary = parameters
        
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
            ), let theJSONText = String(data: theJSONData,
                                        encoding: String.Encoding.ascii) {
            
            somString = theJSONText
        }
        
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
        configuration.timeoutIntervalForRequest = 60 * 60 * 00
        WebServices.manager = Alamofire.SessionManager(configuration: configuration)
        
        var encodeSting : ParameterEncoding = somString
        
        if method == .get {
            encodeSting = URLEncoding.default
        }
        
        Alamofire.request(urlString, method: method!,parameters: parameters,encoding:encodeSting ,  headers:headers  )
            .responseJSON {
                response in
                // Token may have expired. Generate a new one and retry if successful.
             
                switch (response.result) {
                case .success(let value):

                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
//            .responseString { _ in
//            }
//            .responseData { response in
//                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
//                    //print("Data: \(utf8Text)")
//                }
//        }
    }
    
    
    class func postAuthSocket( url : Api,
                             parameters  : [String : Any]  ,
                             method : HTTPMethod? = .post ,
                             contentType: ContentType? = .applicationJson,
                             authorization : (user: String, password: String)? = nil,
                             authorizationToken : String?  = nil,
                             completionHandler: CompletionBlock? = nil,
                             failureHandler: FailureBlock? = nil){
            var headers : HTTPHeaders = [
                "Content-Type": "multipart/form-data",
                "cache-control": "no-cache"
                ]
            
            
//            if contentType! == .applicationJson {
//                if authorization != nil {
//                    if let authorization1 = authorization {
//                        if let authorizationHeader = Request.authorizationHeader(user: authorization1.user, password: authorization1.password) {
//                            headers[authorizationHeader.key] = authorizationHeader.value
//                        }
//                    }
//                }
//                if let token = UserDefaults().currentAccessToken() {
//                    headers["Authorization"] = "Bearer \(token)"
//                }
//            }
            
            
            
            let urlString = url.baseURl()
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
            var somString = ""
            
            let dictionary = parameters
            
            if let theJSONData = try?  JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
                ), let theJSONText = String(data: theJSONData,
                                            encoding: String.Encoding.ascii) {
                
                somString = theJSONText
            }
            
            
            let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
            configuration.timeoutIntervalForRequest = 60 * 60 * 00
            WebServices.manager = Alamofire.SessionManager(configuration: configuration)
            
            var encodeSting : ParameterEncoding = somString
            
            if method == .get {
                encodeSting = URLEncoding.default
            }
            
        Alamofire.request(urlString, method: method!,parameters: parameters, encoding: URLEncoding.default,  headers:headers  )
                .responseJSON {
                    response in
                    switch (response.result) {
                    case .success(let value):
                        
                        completionHandler!(value as! [String : Any] )
                    case .failure(let error):
                        print(error)
                        failureHandler?([:] )
                    }
                }
                .responseString { _ in
                }
                .responseData { response in
                    if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                        //print("Data: \(utf8Text)")
                    }
            }
        }
    
    class func downloadFile(url :String , completionHandler: CompletionBlock? = nil) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        Alamofire.download(
            url,
            method: .get,
            parameters: [:],
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                
                //progress closure
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                print(DefaultDownloadResponse)
                completionHandler?([ : ])
                //here you able to access the DefaultDownloadResponse
                //result closure
            })
    }
    
    ///////////////Add Multi/////////////
    
    class func postAddMulti( url : Api ,jsonObject: [String : Any]  ,
                     method : HTTPMethod? = .post ,
                     completionHandler: CompletionBlock? = nil,
                     
                     failureHandler: FailureBlock? = nil ) {
        
        var urlString = String()
            //.baseURl()
        print("******URL*****\(urlString) *******")

        
        let parameters: Parameters = jsonObject
        Alamofire.request(urlString, method: method!, parameters: parameters)
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
        }
    }
    
    /////////////////
    class func post( url : Api,jsonObject: [String : Any]  ,
                     method : HTTPMethod? = .post ,
                     completionHandler: CompletionBlock? = nil,
                      contentType: ContentType? = .form,
                     failureHandler: FailureBlock? = nil ) {
        
        let headers : HTTPHeaders = [
        //  "Content-Type": "application/form-data; application/x-www-form-urlencoded; ",
        
            :
        ]
        
        var urlString = String()
        urlString = url.baseURl()
        print(urlString)
        
        let parameters: Parameters = jsonObject
        Alamofire.request(urlString, method: method!, parameters: parameters, headers : headers)
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
        }
    }
    
    // GET API
    
    class func get( url : Api,
                    method : HTTPMethod? = .get ,
                    completionHandler: CompletionBlock? = nil,
                    contentType: ContentType? = .form,
                    failureHandler: FailureBlock? = nil ) {
        
        let headers : HTTPHeaders = [
        //  "Content-Type": "application/form-data; application/x-www-form-urlencoded; ",
        
            :
        ]
        
        var urlString = String()
        urlString = url.baseURl()
        print("******URL*****\(urlString) *****")

        
        Alamofire.request(urlString, method: method!, parameters: nil, headers : nil)
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    //print("Data: \(utf8Text)")
                }
        }
    }
    
    
    class func postArrOfDict( url : Api,jsonObject: [String : Any]  ,
                     method : HTTPMethod? = .post ,
                     completionHandler: CompletionBlock? = nil,
                     failureHandler: FailureBlock? = nil ) {
        
        var urlString = String()
        urlString = url.baseURl()
        print(urlString)
        
        let parameters: Parameters = jsonObject
        
        
        Alamofire.request(urlString, method: method!, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON {
                response in
                switch (response.result) {
                case .success(let value):
                    completionHandler!(value as! [String : Any] )
                case .failure(let error):
                    print(error)
                    failureHandler?([:] )
                }
            }
            .responseString { _ in
            }
            .responseData { response in
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    //print("Data: \(utf8Text)")
                }
        }

        
 
    }
    
    class func uploadFiles(url: Api, jsonObject: [String : Any], files: (key: String, path: [URL]), completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (_ , file) in files.path.enumerated() {
                let directoryName = ""
                var url = URL(fileURLWithPath: directoryName)
                let filename = file
                url = url.appendingPathComponent(filename.absoluteString)
                
                
                let filePath = url.absoluteString.replacingOccurrences(of: "file:/", with: "")
                    
                    print("FILE EXISTANCE STATUS 1 : \(FileManager.default.fileExists(atPath: filePath))")
                    
                    if FileManager.default.fileExists(atPath: filePath) {
                    
                    print(file.absoluteString)
                    print(file.pathExtension)
                    
                    
                        if url.pathExtension == "jpg" {
                            // Image)
                            
                            if let profiePic =  UIImage(contentsOfFile: filePath) {
                                let data = profiePic.jpegData(compressionQuality: 0.5)
                                
                                multipartFormData.append(data!, withName: files.key, fileName: file.lastPathComponent, mimeType: "image/\(file.pathExtension)")
                                
                            }
                        }else {
                            // Document
                            
                            let docPaths = url.path.components(separatedBy: "/Users/tech/")
                            
                            do {
                                let documentData = try Data(contentsOf: file)
                                multipartFormData.append(documentData, withName: files.key, fileName: file.lastPathComponent, mimeType: "application/\(file.pathExtension)")
                            }
                            catch {
                                print("Error : \(error.localizedDescription)")
                            }
                        }
                }
                
                /*let filePath = url.path.components(separatedBy: "/file://")
                
                if FileManager.default.fileExists(atPath: filePath[1]) {
                    
                    print(file.absoluteString)
                    print(file.pathExtension)
                    
                    
                    if url.pathExtension == "jpg" {
                        // Image)
                        
                        if let profiePic =  UIImage(contentsOfFile: filePath[1]) {
                            let data = profiePic.jpegData(compressionQuality: 0.5)
                            
                            multipartFormData.append(data!, withName: files.key, fileName: file.absoluteString, mimeType: "image/\(file.pathExtension)")
                            
                        }
                    }else {
                        // Document
                        
                        do {
                            let documentData = try Data(contentsOf: url)
                            multipartFormData.append(documentData, withName: files.key, mimeType: "application/\(file.pathExtension)")
                        }
                        catch {
                            print("Error : \(error.localizedDescription)")
                        }
                    }
                }*/
                
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString) { result  in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { _ in
                                    // Print progress
                                    
                                })
                                upload.responseJSON { response in
                                    switch (response.result) {
                                    case .success(let value):
                                        
                                        print("********ddf*" , value)
                                        
                                        completionHandler!(value as! [String : Any] )
                                    case .failure(let error):
                                        print(error)
                                        failureHandler?([:] )
                                    }
                                    
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
                            
        }
    }
    
    class func uploadSingle( url : Api,jsonObject: [String : Any] , profilePic: (key: String, image: UIImage) , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        var headers = HTTPHeaders()
        if let token = UserDefaults().currentAccessToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            let data = profilePic.image.jpegData(compressionQuality: 0.1)
            
            multipartFormData.append(data!, withName: profilePic.key, fileName: "\(NSUUID().uuidString).jpeg", mimeType: "image/jpeg")
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString, headers: headers) { result  in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { _ in
                                    // Print progress
                                    
                                })
                                upload.responseJSON { response in
                                    switch (response.result) {
                                    case .success(let value):
                                        
                                        print("********ddf*" , value)
                                        
                                        completionHandler!(value as! [String : Any] )
                                    case .failure(let error):
                                        print(error)
                                        failureHandler?([:] )
                                    }
                                    
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
                            
        }
    }
    class func uploadMultile( url : Api,jsonObject: [String : Any] , files :[String] , completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil , progessHandler : ProgressBlock? = nil) {
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.fittingroom.newtimezone.Fitzz")
        configuration.timeoutIntervalForRequest = 60 * 60 * 00
        WebServices.manager = Alamofire.SessionManager(configuration: configuration)
        WebServices.manager.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for (index , file) in files.enumerated() {
                
                let directoryName = ""
                
                var url = URL(fileURLWithPath: directoryName)
                
                let filename = file
                
                url = url.appendingPathComponent(filename)
                
                if FileManager.default.fileExists(atPath: url.path) {
                    
                    if url.pathExtension == "jpg" {
                        
                        if let profiePic =  UIImage(contentsOfFile: url.path) {
                            let data = profiePic.jpegData(compressionQuality: 0.5)
                            
                            
                            multipartFormData.append(data!, withName: "images", fileName: file, mimeType: "image/jpeg")
                            
                            
                            
                        }
                        
                    }else {
                        //     multipartFormData.append( url.path, withName: "File1", fileName: file, mimeType: "video/mp4")
                        // here you can upload any type of video
                        //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
                        
                        
                        multipartFormData.append(url, withName: "images", fileName: file, mimeType: "video/mp4")
                        // here you can upload any type of video
                        //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
                        //  multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
                        
                        
                        // multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
                        
                    }
                    
                    
                }
                
            }
            
            
        },
                                   to: urlString) { result  in
                                    switch result {
                                    case .success(let upload, _, _):
                                        
                                        upload.uploadProgress(closure: { value in
                                            
                                            
                                            progessHandler?(value.fractionCompleted)
                                            print("uploadProgress---" , value)
                                        })
                                        upload.responseJSON { response in
                                            switch (response.result) {
                                            case .success(let value):
                                                completionHandler!(value as! [String : Any] )
                                            case .failure(let error):
                                                print(error)
                                                failureHandler?([:] )
                                            }
                                            
                                        }
                                        
                                    case .failure(let encodingError):
                                        print(encodingError)
                                        failureHandler?([:] )
                                    }
                                    
        }
        
        
    }
    
    class func postMultiPartAuth( url : Api,jsonObject: [String : Any] , profilePic: (key: String, image: UIImage)? = nil, completionHandler: CompletionBlock? = nil, failureHandler: FailureBlock? = nil) {
        
        var headers = HTTPHeaders()
        if let token = UserDefaults().currentAccessToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        let urlString = url.baseURl()
        let parameters: Parameters = jsonObject
        print("******URL*****\(urlString) *****Parameters*****\(parameters)")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            if profilePic != nil {
                if let data = profilePic?.image.jpegData(compressionQuality: 0.1) {
                    multipartFormData.append(data, withName: profilePic!.key, fileName: "\(UUID().uuidString).jpg", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },
                         to: urlString, headers: headers) { result  in
                            switch result {
                            case .success(let upload, _, _):
                                
                                upload.uploadProgress(closure: { _ in
                                    // Print progress
                                    
                                })

                                upload.responseJSON { response in
                                    switch (response.result) {
                                    case .success(let value):
                                        
                                        print("********ddf*" , value)
                                        
                                        completionHandler!(value as! [String : Any] )
                                    case .failure(let error):
                                        print(error)
                                        failureHandler?([:] )
                                    }
                                    
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                            }
                            
        }
    }
    
    private func refreshToken(completion: @escaping ((Bool) -> Void)){
        
        WebServices.postAuth(url: .refreshToken, parameters: [:],refreshToken: true){ (response) in
            print(response)
            if isSuccess(json: response) {
                completion(true)
            }else{
                completion(false)
            }
        } failureHandler: { (error) in
            print(error)
            completion(false)
        }

    }
    
}


struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]
    
    init(array: [Parameters]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}




