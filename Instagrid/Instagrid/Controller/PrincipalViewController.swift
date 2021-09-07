//
//  PrincipalViewController.swift
//  Instagrid
//
//  Created by Yoan on 01/09/2021.
//

import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var photoContainer: UIView!

    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    @IBOutlet weak var imageButton4: UIButton!

    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!

    @IBOutlet weak var imageSelected1: UIImageView!
    @IBOutlet weak var imageSelected2: UIImageView!
    @IBOutlet weak var imageSelected3: UIImageView!

    var typeLayout: Layout = .layout3

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewContainer()
    }

    private func initializeViewContainer() {
        let imageButtons = [imageButton1, imageButton2, imageButton3, imageButton4]
        for button in imageButtons {
            button?.layer.cornerRadius = 8
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

    private func layoutViewCase() {
//        hideImageSelected()
//        viewAllImageButton()

            imageButton2.isHidden = typeLayout == .layout1
            imageSelected1.isHidden = typeLayout != .layout1

            imageButton3.isHidden = typeLayout == .layout2
            imageSelected2.isHidden = typeLayout != .layout2

            imageSelected3.isHidden = typeLayout != .layout3

    }

    private func hideImageSelected() {
        let allImageSelected = [imageSelected1, imageSelected2, imageSelected3]
        for image in allImageSelected {
            image?.isHidden = true
        }
    }

    private func viewAllImageButton() {
        let allImageButton = [imageButton1, imageButton2, imageButton3, imageButton4]
        for imageButton in allImageButton {
            imageButton?.isHidden = false
        }
    }
}
