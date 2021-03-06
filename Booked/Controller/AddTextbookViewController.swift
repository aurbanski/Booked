//
//  AddTextbookController.swift
//  Booked
//
//  Created by Alex Urbanski on 4/2/19.
//  Copyright © 2019 Alex Urbanski. All rights reserved.
//

import UIKit
import Firebase

class AddTextbookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var ISBNTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    var uploadImage: Data?
    
    func toggleEnabledViews(_ option: Bool) {
        titleTextField.isEnabled = option
        authorTextField.isEnabled = option
        ISBNTextField.isEnabled = option
        priceTextField.isEnabled = option
        conditionTextField.isEnabled = option
        submitButton.isEnabled = option
    }
    
// Reference for using the image picker https://www.youtube.com/watch?v=b1vrjt7Nvb0
    @IBAction func imageButtonPressed(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let scaledImage = image.resizeWithPercent(percentage: 0.25)
            uploadImage = scaledImage?.jpegData(compressionQuality: 0.5)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        toggleEnabledViews(false)
        let uuid = NSUUID().uuidString
        let uuidImage = uuid + ".jpeg"
        let storage = Storage.storage().reference().child(uuidImage)
        var downloadURL: String?
        
        if uploadImage != nil {
            storage.putData(uploadImage!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                } else {
                    Storage.storage().reference().child(uuidImage).downloadURL { (url, error) in
                        if error != nil {
                            print(error!)
                        } else {
                            downloadURL = url?.absoluteString
                            let listingsDB = Database.database().reference().child("Postings")
                            let posting = ["UID": uuid, "Title": self.titleTextField.text!, "Author": self.authorTextField.text!, "ISBN": self.ISBNTextField.text!, "Price": self.priceTextField.text!, "Condition": self.conditionTextField.text!, "Seller": Auth.auth().currentUser?.email!, "ImageURL": downloadURL!]
                            
                            listingsDB.child(uuid).setValue(posting) {
                                (error, reference) in
                                if error != nil {
                                    print(error!)
                                    self.view.makeToast("\(error!)", duration: 3.0, position: .top)
                                } else {
                                    self.view.makeToast("Textbook has been posted", duration: 3.0, position: .top)
                                    print("Posting inserted in database")
                                    self.toggleEnabledViews(true)
                                    self.titleTextField.text = ""
                                    self.authorTextField.text = ""
                                    self.ISBNTextField.text = ""
                                    self.priceTextField.text = ""
                                    self.conditionTextField.text = ""
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
