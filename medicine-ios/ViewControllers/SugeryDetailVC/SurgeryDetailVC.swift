//
//  SurgeryDetailVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit

class SurgeryDetailVC: UIViewController {
    @IBOutlet weak var surgeryDetailCV: UICollectionView!
    @IBOutlet weak var doctoradvice: UILabel!
    @IBOutlet weak var hospitlAddress: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var surgerydate: UILabel!
    @IBOutlet weak var typeofSurgery: UILabel!
    @IBOutlet weak var reasonofSurgery: UILabel!
    var index = 0
    var surgeryid = 0
    var surgerydetailDataCount: surgeyDetailModelclass?
    var model = SurgeryDetailVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.callApisurgerydetail(surgeryid: surgeryid)
        self.surgeryDetailCV.delegate = self
        self.surgeryDetailCV.dataSource = self
        let nib = UINib.init(nibName: "AddSurgeryCell", bundle: nil)
        self.surgeryDetailCV.register(nib, forCellWithReuseIdentifier: "AddSurgeryCell")
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  
    
    func showDatanew(){
        self.reasonofSurgery.text = self.surgerydetailDataCount??.reason_of_surgery ?? ""
        self.typeofSurgery.text = self.surgerydetailDataCount??.type_of_surgery ?? ""
        self.surgerydate.text = self.surgerydetailDataCount??.surgery_date ?? ""
        self.hospitalName.text = self.surgerydetailDataCount??.hospital_name ?? ""
        self.hospitlAddress.text = self.surgerydetailDataCount??.hopital_address ?? ""
        self.doctoradvice.text = self.surgerydetailDataCount??.doctor_advice ?? ""
    }
}
extension SurgeryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surgerydetailDataCount??.report_img?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = surgeryDetailCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
        if  let info = self.surgerydetailDataCount??.report_img?[indexPath.row] {
            cell.imagecount.text =  "\(surgerydetailDataCount??.report_img?.count ?? 0)"
            let url = URL(string: imageBaseUrl + (info.image ?? ""))
        cell.mainImage.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "profiledemo"))
    }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.surgeryDetailCV.frame.size.width) / 2
        
        return CGSize(width: width , height: 180)
     }
}
extension SurgeryDetailVC: ResponseProtocol{

    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "BookID Done"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(surgeyDetailModelclass.self, from: jsondata)
                self.surgerydetailDataCount = encodedJson
                self.showDatanew()
                surgeryDetailCV.reloadData()

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

