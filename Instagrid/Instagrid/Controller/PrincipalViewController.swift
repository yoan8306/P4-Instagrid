//
//  PrincipalViewController.swift
//  Instagrid
//
//  Created by Yoan on 01/09/2021.
//

import UIKit

class PrincipalViewController: UIViewController {

    var imagePicker = UIImagePickerController()

    @IBOutlet weak var photoContainer: UIView!

    @IBOutlet weak var viewPhoto1: UIView!
    @IBOutlet weak var viewPhoto2: UIView!
    @IBOutlet weak var viewPhoto3: UIView!
    @IBOutlet weak var viewPhoto4: UIView!

    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    @IBOutlet weak var imageButton4: UIButton!

    @IBOutlet weak var imagePhoto1: UIImageView!
    @IBOutlet weak var imagePhoto2: UIImageView!
    @IBOutlet weak var imagePhoto3: UIImageView!
    @IBOutlet weak var imagePhoto4: UIImageView!

    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!

    @IBOutlet weak var imageSelected1: UIImageView!
    @IBOutlet weak var imageSelected2: UIImageView!
    @IBOutlet weak var imageSelected3: UIImageView!

    var typeLayout: Layout = .layout3
    var imageSelected: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewContainer()
    }

    private func initializeViewContainer() {
        let viewButton = [viewPhoto1, imageButton1, viewPhoto2, imageButton2, viewPhoto3, imageButton3,
                          viewPhoto4, imageButton4]
        for view in viewButton {
            view?.layer.cornerRadius = 8
            photoContainer.layer.cornerRadius = 10
            layoutViewCase()
        }
    }

    @IBAction func buttonLayoutAction(_ sender: UIButton) {
        switch sender {
        case layoutButton1:
            typeLayout = .layout1
        case layoutButton2:
            typeLayout = .layout2
        case layoutButton3:
            typeLayout = .layout3
        default:
            break
        }
        layoutViewCase()
    }

    @IBAction func selectPhoto(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.06709771603, green: 0.3800081015, blue: 0.574813962, alpha: 1)
        switch sender {
        case imageButton1:
            imageSelected = imagePhoto1
        case imageButton2:
            imageSelected = imagePhoto2
        case imageButton3:
            imageSelected = imagePhoto3
        case imageButton4:
            imageSelected = imagePhoto4
        default:
            break
        }
        openLibrary()
    }

    private func openLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    private func layoutViewCase() {
        viewPhoto2.isHidden = typeLayout == .layout1
        imageSelected1.isHidden = typeLayout != .layout1

        viewPhoto3.isHidden = typeLayout == .layout2
        imageSelected2.isHidden = typeLayout != .layout2

        imageSelected3.isHidden = typeLayout != .layout3
    }
}

extension PrincipalViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            if let targetImage = imageSelected {
                targetImage.image = image
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
