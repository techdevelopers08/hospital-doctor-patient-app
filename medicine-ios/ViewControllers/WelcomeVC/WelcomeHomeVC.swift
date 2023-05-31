//
//  WelcomeHomeVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit

class WelcomeHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignVC") as! SignVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
