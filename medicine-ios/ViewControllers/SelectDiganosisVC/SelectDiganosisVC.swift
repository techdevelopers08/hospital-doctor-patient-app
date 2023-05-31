//
//  SelectDiganosisVC.swift
//  medicine-ios
//
//  Created by MAC on 25/05/21.
//

import UIKit

protocol GetDiagnosis {
    func seletedDiagnosis(diagnosisData : DiagnosisModelClass)
}


class SelectDiganosisVC: UIViewController {
    @IBOutlet weak var diagnosisTV: UITableView!
    var model = DiagnosisListVM()
    var diagnosisDataCount: diagnosisModelClass?
    var delegate : GetDiagnosis?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.hitDiagnosisListApi(list_type: 1)
        self.diagnosisTV.reloadData()
        self.diagnosisTV.delegate = self
        self.diagnosisTV.dataSource = self
        
        self.diagnosisTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
       
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addDiagonisBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDiagnisVC") as! AddDiagnisVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
   
}
extension SelectDiganosisVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diagnosisDataCount??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
        cell.diagnosisName.text = diagnosisDataCount??[indexPath.row].reason_name ?? ""
        cell.diagnosisType.text = diagnosisDataCount??[indexPath.row].diagnosis_type ?? ""
        cell.date.text = diagnosisDataCount??[indexPath.row].from_date ?? ""
        let url = URL(string: imageBaseUrl + (diagnosisDataCount??[indexPath.row].diagnosis_image ?? "" ))
        cell.diganosisImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "stethoscope"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.diagnosisDataCount??[indexPath.row] {
            if let del = delegate{
                del.seletedDiagnosis(diagnosisData: data)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
extension SelectDiganosisVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        let body = response["body"]
    if  msg == "DiagnosisList Data"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body ?? [], options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(diagnosisModelClass.self, from: jsondata)
                self.diagnosisDataCount = encodedJson
                self.diagnosisTV.reloadData()
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
