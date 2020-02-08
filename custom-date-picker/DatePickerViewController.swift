//
//  ViewController.swift
//  custom-date-picker
//
//  Created by Alejandra Wetsch on 2/8/20.
//  Copyright © 2020 mawr. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = DatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        datePicker.dataSource = datePicker
        datePicker.delegate = datePicker
    }
    
    @objc func doneDatePicker(){
        if dateTextField.text == ""{
            let date = Util().formatDate(date: Date())
            dateTextField.text = date
        }
        dateTextField.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: .dateChanged, object: nil)
    }
    
    @objc func dateChanged(notification:Notification){
        let userInfo = notification.userInfo
        if let date = userInfo?["date"] as? String{
            self.dateTextField.text = date
        }
    }
}

extension DatePickerViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.selectRow(datePicker.selectedDate(), inComponent: 0, animated: true)
        textField.inputView = datePicker
        let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: CGFloat(44))))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker))
        
        toolBar.setItems([space,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
        NotificationCenter.default.addObserver(self, selector: #selector(dateChanged(notification:)), name:.dateChanged, object: nil)
    }
}

