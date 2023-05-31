//
//  CifiximePillVC.swift
//  medicine-ios
//
//  Created by MAC on 17/05/21.
//

import UIKit

class CifiximePillVC: UIViewController {
    @IBOutlet weak var txtPillCount: UITextField!
    @IBOutlet weak var headingtext: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headingtext.text = "How many \(medname) you take in this?"
      
    }
    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: Any) {
        if self.txtPillCount.text?.trimmingCharacters(in: .whitespaces).isEmpty == true{
            Alert.showSimple("Please Enter Pill Count")
        }else{
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedVC") as! AddMedVC
        medData["on_which_days_do_u_take_this_med"] = ""
        medData["how_pill_u_take_in_this"] = self.txtPillCount.text ?? ""
            medDataArray.append(medData)
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

 
}
