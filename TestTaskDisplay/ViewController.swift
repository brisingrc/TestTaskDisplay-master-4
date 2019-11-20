//
//  ViewController.swift
//  TestTaskDisplay
//
//  Created by Мак on 11/15/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit
//A
class FirstViewController: UIViewController {
    var datePicker = UIDatePicker()
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var savingButton: UIButton!
    @IBOutlet weak var segmentOutletContr: UISegmentedControl!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBAction func addButton(_ sender: Any) {
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon =  #imageLiteral(resourceName: "photo")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true)
    }
   
    
    
      override  func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        checkForSaving()
    }
    func customUI(){
            nameTextField.delegate = self
            datePicker.datePickerMode = .date
            dateTextField.inputView = datePicker
            dateTextField.delegate = self
            // Do any additional setup after loading the view.
            savingButton.layer.cornerRadius = 25    /// радиус закругления закругление
            savingButton.layer.borderWidth = 1   // толщина обводки
            savingButton.backgroundColor = UIColor.gray
            savingButton.clipsToBounds = true
            savingButton.isEnabled = true
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red:0.11, green:0.60, blue:0.87, alpha:1.0)
            toolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePickerView))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            dateTextField.inputAccessoryView = toolBar
        
    }
    
    func formatDateToString(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        dateTextField.text = dateString
        checkForSaving()
        
    }
    

    @objc func closePickerView() {
        print(datePicker.date)
        self.view.endEditing(true)
        formatDateToString(datePicker.date)
        
        
    }
    
    

}

extension FirstViewController: UITextFieldDelegate {
    // Скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    

}
extension FirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // PickerController
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageLabel.image = info[.editedImage] as? UIImage
        imageLabel.contentMode = .scaleAspectFit
        imageLabel.clipsToBounds = true
        addBtn.isHidden = true
    
        dismiss(animated: true)
    }
   func checkForSaving() {
    if nameTextField.hasText && dateTextField.hasText   {
          savingButton.isEnabled = true
           savingButton.backgroundColor = UIColor.red
           print("dd")
       }
   }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//if textField.text?.isEmpty ?? true {
//    print("textField is empty")
//} else {
//    print("textField has some text")
//}

//func checkForSaving() {
//       if (dateTextField.text?.isEmpty && nameTextField.text?.isEmpty) ?? false   {
//          savingButton.isEnabled = true
//          savingButton.backgroundColor = UIColor.red
//           print("  ne пусто")
//       } else {
//
//       }
//   }
