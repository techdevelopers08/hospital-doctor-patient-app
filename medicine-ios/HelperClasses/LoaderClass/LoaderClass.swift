//
//  LoaderClass.swift
//  SurpriseMe User
//
//  Created by Pankaj Mac on 02/09/20.
//  Copyright © 2020 Pankaj Mac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoaderClass: UIViewController , NVActivityIndicatorViewable{
    
    static let shared = LoaderClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.white
    }
    
    func loadAnimation() {
      
        self.startAnimating(CGSize(width: 60, height: 60), message:"", messageFont: UIFont(name: "Montserrat Regular",size: 12.0), type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.1352918446, green: 0.6063622832, blue: 0.7240642905, alpha: 1), padding: 5, displayTimeThreshold: 5, minimumDisplayTime: 5, backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25), textColor: .darkGray, fadeInAnimation: nil)
    }
    
    func stopAnimation(){
        self.stopAnimating()
    }
    
}
