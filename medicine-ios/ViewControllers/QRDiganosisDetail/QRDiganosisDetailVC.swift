//
//  QRDiganosisDetailVC.swift
//  medicine-ios
//
//  Created by MAC on 16/06/21.
//

import UIKit

class QRDiganosisDetailVC: UIViewController {
    @IBOutlet weak var diagnosisdetailCV: UICollectionView!
    @IBOutlet weak var reasoinofDiganosis: UILabel!
    @IBOutlet weak var typeofDiganosis: UILabel!
    @IBOutlet weak var doctorAdvice: UILabel!
    @IBOutlet weak var fromdate: UILabel!
    @IBOutlet weak var todate: UILabel!
    @IBOutlet weak var todateView: UIView!
    @IBOutlet weak var fromdateLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    var index = 0
    var diagnosisid = 0
    var diganosisdetailDataCount: diganosisdetailData?
    var model = DiganosisDetailVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.callApidiagnosisdetail(diagnosisid: diagnosisid)
        self.diagnosisdetailCV.delegate = self
        self.diagnosisdetailCV.dataSource = self
        let nib = UINib.init(nibName: "AddSurgeryCell", bundle: nil)
        self.diagnosisdetailCV.register(nib, forCellWithReuseIdentifier: "AddSurgeryCell")
    }
    func datehide(){
        if typeofDiganosis.text == "OPD"{
            todateView.isHidden = true
            fromdateLbl.text = "Date"
        }else{
            todateView.isHidden = false
            fromdateLbl.text = "From Date"
       }
    }
    func showData(){
        self.reasoinofDiganosis.text = self.diganosisdetailDataCount??.reason_name ?? ""
        self.mainLbl.text = self.diganosisdetailDataCount??.reason_name ?? ""
        self.typeofDiganosis.text = self.diganosisdetailDataCount??.diagnosis_type ?? ""
        self.fromdate.text = self.diganosisdetailDataCount??.from_date ?? ""
        self.todate.text = self.diganosisdetailDataCount??.to_date ?? ""
        self.doctorAdvice.text = self.diganosisdetailDataCount??.doctor_advice ?? ""
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func closebtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension QRDiganosisDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diganosisdetailDataCount??.diagnosis_report_img?.count ?? 0
//        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = diagnosisdetailCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
        if  let info = self.diganosisdetailDataCount??.diagnosis_report_img?[indexPath.row] {
            cell.imagecount.text =  "\(diganosisdetailDataCount??.diagnosis_report_img?.count ?? 0)"
            let url = URL(string: imageBaseUrl + (info.image ?? ""))
        cell.mainImage.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "profiledemo"))
        }
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.diagnosisdetailCV.frame.size.width) / 2
        
        return CGSize(width: width , height: 180)
     }
    
}
extension QRDiganosisDetailVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "BookID Done"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(diganosisdetailData.self, from: jsondata)
                self.diganosisdetailDataCount = encodedJson
                diagnosisdetailCV.reloadData()
                self.showData()
                self.datehide()
                
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
