//
//  QrDetailVC.swift
//  medicine-ios
//
//  Created by MAC on 18/05/21.
//

import UIKit
import IBAnimatable
class QrDetailVC: UIViewController {
   
    @IBOutlet weak var diganosisTV: UITableView!
    @IBOutlet weak var medicionTV: UITableView!
    @IBOutlet weak var surgeryTV: UITableView!
    @IBOutlet weak var soscontactTV: UITableView!
    
    @IBOutlet weak var diganosisView: UIView!
    @IBOutlet weak var medicionView: UIView!
    @IBOutlet weak var surgeryView: UIView!
    @IBOutlet weak var soscontactView: UIView!
    @IBOutlet weak var diganosisfilter: AnimatableView!
    @IBOutlet weak var surgeryfilter: AnimatableView!
    
    @IBOutlet weak var useremailLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileImg: AnimatableImageView!
    
    @IBOutlet weak var QrdetailCV: UICollectionView!
    var userID = ""
    var select = 0
    var model = QrDetailVM()
    var qrdetailModelData: QrDetailModelClass?
    var mainlbl = ["Diganosis","Medication","Surgery","Sos"]
    var isSelected = 0
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.hitApiscannerinfo(userid: Int(userID) ?? 0)
        self.diganosisTV.delegate = self
        self.diganosisTV.dataSource = self
        self.medicionTV.delegate = self
        self.medicionTV.dataSource = self
        self.surgeryTV.delegate = self
        self.surgeryTV.dataSource = self
        self.soscontactTV.delegate = self
        self.soscontactTV.dataSource = self
        self.QrdetailCV.delegate = self
        self.QrdetailCV.dataSource = self
         type = "all"
        self.surgeryTV.register(UINib.init(nibName:"SurgeryTVCell" , bundle: nil), forCellReuseIdentifier: "SurgeryTVCell")
        self.diganosisTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
        self.medicionTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
        self.soscontactTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
        self.QrdetailCV.register(UINib.init(nibName:"QrdetailCVCell" , bundle: nil), forCellWithReuseIdentifier: "QrdetailCVCell")
    }
   
    @IBAction func closeBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func diganosisfilterBtn(_ sender: Any) {
        if diganosisfilter.isHidden == true{
            diganosisfilter.isHidden = false
        }else{
            diganosisfilter.isHidden = true
        }
    }
    @IBAction func surgeryfilterBtn(_ sender: Any) {
        if diganosisfilter.isHidden == true{
            diganosisfilter.isHidden = false
        }else{
            diganosisfilter.isHidden = true
        }
        
    }
    @IBAction func  surgeryfilteroption(_ sender: UIButton) {
        let tag = sender.tag

        self.select = sender.tag
        
        if tag == 1 {
//            self.model.hitSurgeryListApi(listtype: 1)
//            filterView.isHidden = true
        }else{
//            self.model.hitSurgeryListApi(listtype: 2)
//            filterView.isHidden = true
        }
        
    }
    @IBAction func diganosisfilteroptionBtn(_ sender: UIButton) {
        let tag = sender.tag

        self.select = sender.tag
        
        if tag == 1 {
            mainlbl.removeAll()
            qrdetailModelData?.diagnosis?.removeAll()
            self.model.hitApiscannerinfo(userid: Int(userID) ?? 0)
            type = "OPD"
            diganosisTV.reloadData()
        }else  if tag == 2{
            qrdetailModelData?.diagnosis?.removeAll()
            self.model.hitApiscannerinfo(userid: Int(userID) ?? 0)
            type = "Hospitlizition"
            diganosisTV.reloadData()
        }
    }
    func showdata(){
        self.useremailLbl.text = self.qrdetailModelData?.email ?? ""
        self.usernameLbl.text = self.qrdetailModelData?.name ?? ""
        let url = URL(string: imageBaseUrl + (qrdetailModelData?.profile_image ?? ""))
        self.profileImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "color line"))
    }
}

extension QrDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainlbl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QrdetailCV.dequeueReusableCell(withReuseIdentifier: "QrdetailCVCell", for: indexPath ) as! QrdetailCVCell
        if indexPath.item == self.isSelected{
            cell.mainLbl.textColor = #colorLiteral(red: 0.1480824947, green: 0.8059642911, blue: 0.7712526917, alpha: 1)
        }else{
            cell.mainLbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
             }
        cell.mainLbl.text = mainlbl[indexPath.item]
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.isSelected = indexPath.item
        if indexPath.item == 0 {
            diganosisView.isHidden = false
            medicionView.isHidden = true
            surgeryView.isHidden = true
            soscontactView.isHidden = true
            
        }
        else if indexPath.item == 1 {
            diganosisView.isHidden = true
            medicionView.isHidden = false
            surgeryView.isHidden = true
            soscontactView.isHidden = true
        }
        else if indexPath.item == 2 {
            diganosisView.isHidden = true
            medicionView.isHidden = true
            surgeryView.isHidden = false
            soscontactView.isHidden = true
        }else{
            diganosisView.isHidden = true
            medicionView.isHidden = true
            surgeryView.isHidden = true
            soscontactView.isHidden = false
        }
        self.QrdetailCV.reloadData()
    }
   
}
extension QrDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == diganosisTV{
        return qrdetailModelData?.diagnosis?.count ?? 0
        }else if tableView == medicionTV{
            return qrdetailModelData?.medications?.count ?? 0
        }else if tableView == surgeryTV{
            return qrdetailModelData?.surgery?.count ?? 0
        }else{
            return qrdetailModelData?.sos_contact?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == diganosisTV{
            let cell = diganosisTV.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
            if type == "OPD"{
                if let valueType = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type {
                    if valueType == "OPD"{
                        cell.menuBtn.isHidden = true
                        cell.diagnosisName.text = qrdetailModelData?.diagnosis?[indexPath.row].reason_name ?? ""
                        cell.diagnosisType.text = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type ?? ""
                        cell.date.text = qrdetailModelData?.diagnosis?[indexPath.row].from_date ?? ""
                    }
                }
            }else if type == "Hospitlizition"{
                if let valueType = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type{
                    if valueType == "Hospitlizition"{
                        cell.menuBtn.isHidden = true
                        cell.diagnosisName.text = qrdetailModelData?.diagnosis?[indexPath.row].reason_name ?? ""
                        cell.diagnosisType.text = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type ?? ""
                        cell.date.text = qrdetailModelData?.diagnosis?[indexPath.row].from_date ?? ""
                    }
                }
            }else if type == "all"{
                
            cell.menuBtn.isHidden = true
            cell.diagnosisName.text = qrdetailModelData?.diagnosis?[indexPath.row].reason_name ?? ""
            cell.diagnosisType.text = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type ?? ""
            cell.date.text = qrdetailModelData?.diagnosis?[indexPath.row].from_date ?? ""
            }

            return cell
        }else if tableView == medicionTV{
            let cell = medicionTV.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
            cell.menuBtn.isHidden = true
            cell.diagnosisName.text = qrdetailModelData?.medications?[indexPath.row].reason_name ?? ""
            cell.diagnosisType.text = "\(qrdetailModelData?.medications?[indexPath.row].total_med ?? 0)Medicion"
            cell.date.text = qrdetailModelData?.medications?[indexPath.row].med_date ?? ""
            return cell
        }else if tableView == surgeryTV{
            let cell = surgeryTV.dequeueReusableCell(withIdentifier: "SurgeryTVCell", for: indexPath) as! SurgeryTVCell
            cell.menuBtn.isHidden = true
            cell.surgeryName.text = qrdetailModelData?.surgery?[indexPath.row].reason_of_surgery ?? ""
            cell.surgeryType.text = qrdetailModelData?.surgery?[indexPath.row].type_of_surgery ?? ""
            cell.surgerydate.text = qrdetailModelData?.surgery?[indexPath.row].surgery_date ?? ""
            return cell
        }else {
            let cell = soscontactTV.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
            cell.menuBtn.isHidden = true
            cell.clanderimg.isHidden = true
            cell.calenderWidth.constant = 0
            cell.diganosisImg.image = #imageLiteral(resourceName: "call")
            cell.imagetop.constant = 50
            cell.imageweidth.constant = 50
            cell.diagnosisName.text = qrdetailModelData?.sos_contact?[indexPath.row].sc_name ?? ""
            cell.diagnosisType.text = qrdetailModelData?.sos_contact?[indexPath.row].sc_relation ?? ""
            cell.date.text = "+91" + (qrdetailModelData?.sos_contact?[indexPath.row].sc_number ?? "")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == diganosisTV{
            if type == qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_type ?? ""{
               return 150
            }else if type == "all"{
                return 150
            }else{
                return 0
            }
        }else{
            return 150

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == diganosisTV{
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRDiganosisDetailVC") as! QRDiganosisDetailVC
            vc.index = indexPath.row
            vc.diagnosisid = qrdetailModelData?.diagnosis?[indexPath.row].diagnosis_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        }else if tableView == medicionTV{
            let vc = storyboard?.instantiateViewController(withIdentifier: "QrMedicionDetailVC")
                as! QrMedicionDetailVC
            vc.index = indexPath.row
            vc.medicationsid = qrdetailModelData?.medications?[indexPath.row].medications_id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else if tableView == surgeryTV{
            let vc = storyboard?.instantiateViewController(withIdentifier: "QRSurgeryDetailVC") as! QRSurgeryDetailVC
            vc.index = indexPath.row
            vc.surgeryid = qrdetailModelData?.surgery?[indexPath.row].surgery_id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
}
extension QrDetailVC: ResponseProtocol{

    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        let body = response["user_id"] as? String
        if msg == "BookID Done"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(qrdetailModelClass.self, from: jsondata)
                self.qrdetailModelData = encodedJson
                showdata()
                surgeryTV.reloadData()
                diganosisTV.reloadData()
                medicionTV.reloadData()
                soscontactTV.reloadData()

            }catch {
            }
        }
    }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}

