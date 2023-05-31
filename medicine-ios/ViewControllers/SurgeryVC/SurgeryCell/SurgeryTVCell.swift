//
//  SurgeryTVCell.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit

class SurgeryTVCell: UITableViewCell {
    @IBOutlet weak var surgeryName: UILabel!
    @IBOutlet weak var surgeryType: UILabel!
    @IBOutlet weak var surgerydate: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func menuBtn(_ sender: Any) {
        if menuView.isHidden == true{
            menuView.isHidden = false
        }else{
            menuView.isHidden = true
        }
    }
}
