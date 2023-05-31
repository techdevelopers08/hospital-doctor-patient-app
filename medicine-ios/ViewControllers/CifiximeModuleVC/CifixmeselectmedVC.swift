//
//  CifixmeselectmedVC.swift
//  medicine-ios
//
//  Created by MAC on 17/05/21.
//

import UIKit

class CifixmeselectmedVC: UIViewController {
    @IBOutlet weak var showdataTF: UITextField!
    @IBOutlet weak var dropdownTV: UITableView!
    var data = ["Yes","No","Only as Needed"]
    var indexPath = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdownTV.isHidden = true
        dropdownTV.delegate = self
        dropdownTV.dataSource = self
        dropdownTV.register(UINib(nibName: "SelectdataTVCell", bundle: nil), forCellReuseIdentifier: "SelectdataTVCell")
    }
    @IBAction func dropDown(_ sender: Any) {
        if  dropdownTV.isHidden == true{
       
            dropdownTV.isHidden = false
        }else{
          
            dropdownTV.isHidden = true
        }
    }
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: Any) {
        if indexPath ==  0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximetimeVC") as! CifiximetimeVC
            medData["do_u_nedd_to_take_this_med_every_day"] = "1"
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximeweekVC") as! CifiximeweekVC
            medData["do_u_nedd_to_take_this_med_every_day"] = "2"
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximePillVC") as! CifiximePillVC
            medData["do_u_nedd_to_take_this_med_every_day"] = "3"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
extension CifixmeselectmedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropdownTV.dequeueReusableCell(withIdentifier: "SelectdataTVCell", for: indexPath) as! SelectdataTVCell
        cell.mainLbl.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = dropdownTV.frame.height / 3
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectionData = data[indexPath.item]
        showdataTF.text = selectionData
        dropdownTV.isHidden = true
        self.indexPath = indexPath.row
//        if indexPath.row ==  0{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximetimeVC") as! CifiximetimeVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else if indexPath.row == 1{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximeweekVC") as! CifiximeweekVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximePillVC") as! CifiximePillVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }

}
