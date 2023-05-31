//
//  CifiximeweekTVCell.swift
//  medicine-ios
//
//  Created by MAC on 17/05/21.
//

import UIKit
import IBAnimatable

class CifiximeweekTVCell: UITableViewCell {

    @IBOutlet weak var weekLbl: UILabel!
    @IBOutlet weak var checkBoxBtn: AnimatableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.checkBoxBtn.isSelected = false
        if checkBoxBtn.imageView?.image == UIImage(named: "uncheck"){
            Alert.showSimple("Please check the box")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func checkboxBtn(_ sender: Any) {
//        if checkBoxBtn.isSelected == false {
//            checkBoxBtn.isSelected = true
//        }else{
//            checkBoxBtn.isSelected = false
//        }
    }
    
}
