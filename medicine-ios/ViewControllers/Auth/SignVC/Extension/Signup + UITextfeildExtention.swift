//
//  Signup + UITextfeildExtention.swift
//  JumpOn
//
//  Created by MAC on 23/04/21.
//

import Foundation
import UIKit

extension SignVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
               let currentCharacterCount = textField.text?.count ?? 0
               if range.length + range.location > currentCharacterCount {
                   return false
           }
               let newLength = currentCharacterCount + string.count - range.length
               return newLength <= 5
       }
}
