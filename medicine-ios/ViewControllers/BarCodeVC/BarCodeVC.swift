//
//  BarCodeVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit

class BarCodeVC: UIViewController {
    @IBOutlet weak var barCodeView: UIView!
    var userID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //create barcode image
        let barCodeImage = UIImage()
        let barCode = UIImageView(image: barCodeImage)
        barCode.image = generateBarcode(from: userID)
        //add barcode to the scene
        barCode.frame = CGRect(x: -15, y: -10, width: 130, height: 130)
        barCodeView.addSubview(barCode)
      
    }
    func generateBarcode(from string: String) -> UIImage? {
           let data = string.data(using: String.Encoding.ascii)
//        let data = string.da

           if let filter = CIFilter(name: "CIQRCodeGenerator") {
               filter.setValue(data, forKey: "inputMessage")
               if let output = filter.outputImage {
                   return UIImage(ciImage: output)
               }
           }
          
           return nil
       }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
