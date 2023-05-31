import Foundation
import UIKit
 @objc protocol  LeoElementable {
    var leoText : String { get  }
    @objc optional var leoTextOnPicker : String { get  }
    
    
}

class ModelDetails  {
}
extension ModelDetails : LeoElementable{
 
    var leoText: String {
        return "dsda"
    }
}

class LeoAnyElementTextField : UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    enum SelectedBy {
        
        case didSelectRow
        case doneButtonTap
    }
    

    var pickerView: UIPickerView = UIPickerView()
    
    @IBInspectable var shouldFirst: Bool = false
    
    var elements : [LeoElementable] = []
    var selectedElement : LeoElementable?
  
    // Use this class to have single image.
    public  var closureDidSelectElement: ((_ subcategory: LeoElementable , SelectedBy) -> Void)?
    
    func configure(withElements : [LeoElementable]) {
        elements = withElements
    
        if elements.count <= 0 {
            self.isEnabled = false
        
        }else {
            self.isEnabled = true
        }
       
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        
        if shouldFirst {
            if let index = pickerView.selectedRow(inComponent: 0) as Int? {
                
                if elements.count > 0 {
                    let element: LeoElementable = elements[index]
                    self.text = element.leoText
                }
                
            }
        }

    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addInputAccessoryView()
        
        self.inputView = pickerView
        
        //self.textColor = AppColor.theme.color
        pickerView.dataSource = self
        
        pickerView.delegate = self
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        if elements.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        
            if shouldFirst {
                if let index = pickerView.selectedRow(inComponent: 0) as Int? {
                    
                    if elements.count > 0 {
                        let element: LeoElementable = elements[index]
                        self.text = element.leoText
                    }
                    
                }

        }
        
        
    }
    
    func addInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuDoneButtonTapped(sender:)))
        let label = UILabel(frame: CGRect(x: 3, y: 5, width: 20, height: 20))
        label.text = self.placeholder
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor =  .clear
       
        let barButton = UIBarButtonItem(customView: label)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var arraybutton: [UIBarButtonItem] = []
        arraybutton.append(space)
        arraybutton.append(barButton)
        arraybutton.append(space)
        arraybutton.append(donebutton)
        toolbar.setItems(arraybutton, animated: true)
        self.inputAccessoryView = toolbar
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        print("\(String(describing: self.inputAccessoryView))")
    }
    
    deinit {
    }
    @objc func menuDoneButtonTapped(sender _: UIBarButtonItem) {
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            let element: LeoElementable = elements[index]
            self.text = element.leoText
            closureDidSelectElement?(element, LeoAnyElementTextField.SelectedBy.doneButtonTap)
            selectedElement = element
        }
        _ = resignFirstResponder()
        
    }
    
    func pickerTextFieldEditingDidEnd(_: UITextField) {
        
    }
    
    // MARK: PickerViewDelegate
    public func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return elements.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let element: LeoElementable = elements[row]
        
        if element.leoTextOnPicker != nil {
        return element.leoTextOnPicker
        }else {
        return element.leoText
        }
        

    }
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let element: LeoElementable = elements[row]
        self.text = element.leoText
        closureDidSelectElement?(element, LeoAnyElementTextField.SelectedBy.didSelectRow)
       // selectedElement = element
    }
}
