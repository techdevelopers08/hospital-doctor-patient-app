//
//  AddMedVC.swift
//  medicine-ios
//
//  Created by MAC on 11/05/21.
//

import UIKit
import IBAnimatable
class AddMedVC: UIViewController {
   
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var recentaddedTV: UITableView!
    @IBOutlet weak var recentview: UIView!
    @IBOutlet weak var doneBtn: AnimatableButton!
    @IBOutlet weak var nextBtn: AnimatableButton!
    
    @IBOutlet weak var txtMedName: UITextField!
    
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recentaddedTV.delegate = self
        self.recentaddedTV.dataSource = self
        
        self.recentaddedTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        if medDataArray.count == 0{
            recentaddedTV.isHidden = true
            doneBtn.isHidden = true
            backBtn.isHidden = false
        }else{
            recentaddedTV.isHidden = false
            doneBtn.isHidden = false
            backBtn.isHidden = true
            nextBtn.setTitle("ADD MORE", for: .normal)
        }
    }
   
// MARK: - ActionBtn
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
        
    @IBAction func doneBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedicionVC") as! AddMedicionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if self.txtMedName.text?.trimmingCharacters(in: .whitespaces).isEmpty == true{
            Alert.showSimple("Please Enter Med.")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedSelectVC") as! AddMedSelectVC
            medData["wht_med_would_u_like_to_add"] = self.txtMedName.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
   
}

extension AddMedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return diagnosisDataCount?.count ?? 0
        return medDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentaddedTV.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
//        cell.diagnosisName.text = diagnosisDataCount?[indexPath.row]?.reason_name ?? ""
//        cell.diagnosisType.text = diagnosisDataCount?[indexPath.row]?.diagnosis_type ?? ""
//        cell.date.text = diagnosisDataCount?[indexPath.row]?.from_date ?? ""
//        let url = URL(string: imageBaseUrl + (diagnosisDataCount?[indexPath.row]?.diagnosis_image ?? "" ))
//        cell.diganosisImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "stethoscope"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DiagnosisDetailVC") as! DiagnosisDetailVC
//        vc.index = indexPath.row
//        vc.diagnosisid = diagnosisDataCount?[indexPath.row]?.diagnosis_id ?? 0
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
