
import Foundation

let baseUrl  = "http://api.deploywork.com:4041/"
let imageBaseUrl = "http://deploywork.com/api/medicine"
var medData = [String:Any]()
var medDataArray = [[String:Any]]()
var medname = ""
let userIDGloble = UserDefaults.standard.value(forKey: UserDefaultKey.kUserID) as? String ?? ""

extension Api {
    func baseURl() -> String {
        
        return  baseUrl + self.rawValued()
    }
}


enum Api: Equatable {
    
    case login
    case signUp
    case adddiagnosis
    case addsurgery
    case diagnosisList
    case mediciontype
    case medicinestrength
    case refreshToken
    case imageUpload
    case diganosisdetail
    case diagnosistype
    case addmedicine
    case medicinelist
    case mediciondetail
    case signlemeddetail
    case surgeryList
    case surgerydetail
    case addsosDetail
    case contactList
    case updateProfile
    case changePass
    case deletesoscontact
    case imageupload
    case forgotpass
    case editdiagnosis
    case editsoscontact
    case deletediagnosis
    case deletemedicion
    case deletesurgery
    case editsurgery
    case scannerinfo
    case medata
    
    func rawValued() -> String {
        switch self {
        case .login:
            return "user/login"
        case .signUp:
            return "user/register"
        case .adddiagnosis:
            return "home/add_diagnosis"
        case .diagnosisList:
            return "home/diagnosis_list"
        case .refreshToken:
            return ""
        case .imageUpload:
            return "uploadimage"
        case .diganosisdetail:
            return "home/diagnosis_detail"
        case .mediciontype:
            return "home/medicine_type"
        case .medicinestrength:
            return "home/medicine_strength"
        case .diagnosistype:
            return "home/diagnosis_type"
        case .addmedicine:
            return "home/add_medicine"
        case .medicinelist:
            return "home/all_medications_list"
        case .mediciondetail:
            return "home/list_of_medications_medicine"
        case .signlemeddetail:
            return "home/single_medicine_detail"
        case .surgeryList:
            return "home/surgery_list"
        case .surgerydetail:
            return "home/surgery_detail"
        case .addsurgery:
            return "home/add_surgery"
        case .addsosDetail:
            return "home/add_sos_contact"
        case .contactList:
             return "home/contactList"
        case .updateProfile:
             return "user/updateProfile"
        case .changePass:
             return "user/changePassword"
        case .deletesoscontact:
             return "home/delete_sos_contact"
        case .forgotpass:
             return "user/forgotUserPassword"
        case .editdiagnosis:
            return "home/edit_diagnosis"
        case .editsoscontact:
            return "home/edit_sos_contact"
        case .scannerinfo:
            return "home/scanner_get_all_info_of_user"
        case .imageupload:
            return "uploadimage"
        case .deletediagnosis:
            return "home/delete_diagnosis"
        case .deletemedicion:
            return "home/delete_medication"
        case .deletesurgery:
            return "home/delete_surgery"
        case .editsurgery:
            return "home/edit_surgery"
        case .medata:
            return "user/me_data"
        }
    }
}

func isSuccess(json : [String : Any]) -> Bool{
    if let isSucess = json["status"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    if let isSucess = json["status"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["success"] as? String {
        if isSucess == "200" {
            return true
        }
    }
    if let isSucess = json["success"] as? Int {
        if isSucess == 200 {
            return true
        }
    }
    return false
}

func message(json : [String : Any]) -> String{
    if let message = json["message"] as? String {
        return message
    }
    if let message = json["message"] as? [String:Any] {
        if let msg = message.values.first as? [String] {
            return msg[0]
        }
    }
    if let error = json["error"] as? String {
        return error
    }
    
    return " "
}


func isBodyCount(json : [[String : Any]]) -> Int{
    return json.count
}
