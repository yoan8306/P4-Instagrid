//
//  PhotoAccess.swift
//  Instagrid
//
//  Created by Yoan on 04/09/2021.
//

import Foundation

// add to controller
// UIImagePickerControllerDelegate, UINavigationControllerDelegate

/*
@IBOutlet weak var imageView: UIImageView!
var imagePicker = UIImagePickerController()
*/

// insert in button

/*
if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
    print("Button capture")
    
    imagePicker.delegate = self
    imagePicker.sourceType = .savedPhotosAlbum
    imagePicker.allowsEditing = false
    
    present(imagePicker, animated: true, completion: nil)
}
*/

// after
/*
func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
    self.dismiss(animated: true, completion: { () -> Void in
        
    })
    
    imageView.image = image
}
*/
