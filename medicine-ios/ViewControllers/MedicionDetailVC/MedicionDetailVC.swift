//
//  MedicionDetailVC.swift
//  medicine-ios
//
//  Created by MAC on 31/05/21.
//

import UIKit

class MedicionDetailVC: UIViewController {
    
    @IBOutlet weak var reasonName: UILabel!
    @IBOutlet weak var mediciontakeLbl: UILabel!
    @IBOutlet weak var strengthofMed: UILabel!
    @IBOutlet weak var typeofMedicion: UILabel!
    @IBOutlet weak var medicionName: UILabel!
    @IBOutlet weak var mediciondetailCV: UICollectionView!
    var index = 0
    var medicationsid = 0
    var model = MedDetailVM()
    var modelmed = MedDetailDataVM()
    var medicionDetailDataCount: medicionDetailModelClass?
    var mediciondetailDataCounttop: mediciondetailDatatop?
    var mainlbl = ["Declofenic","Cefixime","Asprine","Sos"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.modelmed.delegate = self
        self.model.callApimediciondetail(medicationsid: medicationsid)
//        self.modelmed.callApisinglemeddetail(medid: 1)
//        self.modelmed.callApisinglemeddetail(medid: 142)
    }
    func showDatanew(){
        self.reasonName.text = self.medicionDetailDataCount??.first?.wht_med_would_u_like_to_add ?? ""
//        self.mediciontakeLbl.text = self.medicionDetailDataCount??.do_u_nedd_to_take_this_med_every_day ?? ""
        self.strengthofMed.text = "\(self.medicionDetailDataCount??.first?.what_strength_is_the_med ?? 0)" + " " + (self.medicionDetailDataCount??.first?.med_strength_name ?? "")
        self.typeofMedicion.text = self.medicionDetailDataCount??.first?.med_type_name ?? ""
        self.medicionName.text = self.medicionDetailDataCount??.first?.wht_med_would_u_like_to_add ?? ""

    }
    
    @IBAction func diganosisDetailBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DiagnosisDetailVC") as! DiagnosisDetailVC
//        vc.index = sender.tag
//        vc.diagnosisid = medicionDetailModelClass??[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
}
extension MedicionDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediciondetailDataCounttop??.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediciondetailCV.dequeueReusableCell(withReuseIdentifier: "QrdetailCVCell", for: indexPath ) as! QrdetailCVCell
//        cell.mainLbl.text = mainlbl[indexPath.row]
        self.modelmed.callApisinglemeddetail(medid: self.mediciondetailDataCounttop??[indexPath.row].med_id ?? 0)
        if  let info = self.mediciondetailDataCounttop??[indexPath.row]{
        cell.mainLbl.text = info.wht_med_would_u_like_to_add ?? ""
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = mediciondetailCV.cellForItem(at: indexPath) as! QrdetailCVCell
        view.mainLbl.textColor = #colorLiteral(red: 0.01039823983, green: 0.8336408138, blue: 0.7908363938, alpha: 1)
        showDatanew()
        self.modelmed.callApisinglemeddetail(medid: self.mediciondetailDataCounttop??[indexPath.row].med_id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let view = mediciondetailCV.cellForItem(at: indexPath) as! QrdetailCVCell
        view.mainLbl.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        mediciondetailCV.deselectItem(at: indexPath, animated: true)
    }
    
}
extension MedicionDetailVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "Medicion detail"{
            do {
             
                let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
                                        let encodedJson = try JSONDecoder().decode(mediciondetailDatatop.self, from: jsondata)
                                        self.mediciondetailDataCounttop = encodedJson
                                        self.showDatanew()
                                        self.mediciondetailCV.delegate = self
                                       self.mediciondetailCV.dataSource = self
                                       self.mediciondetailCV.register(UINib.init(nibName:"QrdetailCVCell" , bundle: nil), forCellWithReuseIdentifier: "QrdetailCVCell")
                                       self.mediciondetailCV.reloadData()
               
            }catch {
                
            }
        }else {
            do {
                let body = response["body"]
                 let jsondata = try JSONSerialization.data(withJSONObject: body ?? [], options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(medicionDetailModelClass.self, from: jsondata)
                             self.medicionDetailDataCount = encodedJson
                             self.showDatanew()
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

