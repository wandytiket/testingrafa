//
//  ViewController.swift
//  Amphibian
//
//  Created by Rafa Fahd on 25/10/18.
//  Copyright © 2018 Team Work. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jumlahPinjamanTextField: UITextField!
    @IBOutlet weak var lamaPinjamanTextField: UITextField!

    
    private var pickerView: UIPickerView? = nil
    
    private var pickerData: [String] = []
    
    private var isJumlahPinjaman: Bool = false
    private var isLamaPinjaman: Bool = false
    
    private var jumlahPinjamanSelectedRow: Int = 0
    private var lamaPinjamanSelectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
    }
    
    private func setupTextField(){
        jumlahPinjamanTextField.delegate = self
        lamaPinjamanTextField.delegate = self
        
        jumlahPinjamanTextField.text = "500000"
        lamaPinjamanTextField.text = "1"
        
        jumlahPinjamanTextField.tag = 1
        lamaPinjamanTextField.tag = 2
    }
    
    private func setupPickerView() -> UIPickerView {
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        pickerView?.backgroundColor = UIColor.white
        pickerView?.showsSelectionIndicator = true
        
        return pickerView ?? UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
    }
    
    private func toolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker(sender:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    @objc private func donePicker(sender: UIBarButtonItem){
        self.view.endEditing(true)
    }
    
    @objc private func cancelPicker(sender: UIBarButtonItem){
        self.view.endEditing(true)
    }

}


extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            isJumlahPinjaman = true
            isLamaPinjaman = false
            pickerData = ["500000", "1000000", "2000000", "3000000", "5000000", "7000000", "8000000"]
            
            jumlahPinjamanTextField.inputView = setupPickerView()
            jumlahPinjamanTextField.inputAccessoryView = toolBar()
            
            pickerView?.selectRow(jumlahPinjamanSelectedRow, inComponent: 0, animated: true)
            pickerView = nil
        }
        else if textField.tag == 2 {
            isLamaPinjaman = true
            isJumlahPinjaman = false
            pickerData = ["1", "2", "3", "4"]
            
            lamaPinjamanTextField.inputView = setupPickerView()
            lamaPinjamanTextField.inputAccessoryView = toolBar()
            pickerView?.selectRow(lamaPinjamanSelectedRow, inComponent: 0, animated: true)
            pickerView = nil
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isJumlahPinjaman {
            jumlahPinjamanSelectedRow = row
            jumlahPinjamanTextField.text = pickerData[jumlahPinjamanSelectedRow]
        } else if isLamaPinjaman {
            lamaPinjamanSelectedRow = row
            lamaPinjamanTextField.text = pickerData[lamaPinjamanSelectedRow]
        }
    }
    
}


