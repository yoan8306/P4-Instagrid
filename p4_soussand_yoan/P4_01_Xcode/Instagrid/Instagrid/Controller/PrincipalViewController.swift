//
//  PrincipalViewController.swift
//  Instagrid
//
//  Created by Yoan on 01/09/2021.
//

import UIKit

class PrincipalViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!

    @IBOutlet weak var photoContainer: UIView!
    @IBOutlet var uiViewPhoto: [UIView]!
    @IBOutlet var buttonPhoto: [UIButton]!
    @IBOutlet var imagePhoto: [UIImageView]!

    @IBOutlet var layoutButton: [UIButton]!
    @IBOutlet var imageOfSelected: [UIImageView]!
    // MARK: - properties
    private var imagePicker = UIImagePickerController()
    private var typeLayout: Layout = .layout3
    private var imageSelected: UIImageView?

    // MARK: - Life cycle
    /// prepare interface
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGestureToPhotoContainer()
        initializeViewContainer()
        addTagButtonPhoto()
    }

    /// for detect orientation and change label and arrow image
    /// - Parameters:
    ///   - size: size screen
    ///   - coordinator: if coordinator change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            arrowImage.image = UIImage(named: "Arrow Left")
            swipeLabel.text = "Swipe left to share"

        } else {
            arrowImage.image = UIImage(named: "Arrow Up")
            swipeLabel.text = "Swipe up to share"
        }
    }

    // MARK: - IBAction
    /// identify what photo want change
    /// - Parameter sender: identify button taped
    @IBAction func selectPhoto(_ sender: UIButton) {
        imageSelected = imagePhoto[sender.tag]
        openPhotoLibrary()
    }

    /// when select layout button place image selected on the button
    /// - Parameter sender: identify button layout selected
    @IBAction func buttonLayoutAction(_ sender: UIButton) {
        switch sender {
        case layoutButton[0]:
            typeLayout = .layout1
        case layoutButton[1]:
            typeLayout = .layout2
        case layoutButton[2]:
            typeLayout = .layout3
        default:
            break
        }
        layoutViewCase()
    }

    ///  identify direction swiping if left or up and allow swiping or not
    /// - Parameter sender: swipe of gestureRecognizer
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        let deviceOrientation = UIDevice.current.orientation

        switch deviceOrientation {
        case .landscapeLeft, .landscapeRight:
            if sender.direction == .left {
                animateSwipe(translationX: -view.frame.width, translationY: 0)
            }
        case .portrait:
            if sender.direction == .up {
                animateSwipe(translationX: 0, translationY: -view.frame.height)
            }
        default: break
        }
    }

    // MARK: - private function
    /// declare tag in button photo
    private func addTagButtonPhoto() {
        for indexTag in 0...buttonPhoto.count - 1 {
            buttonPhoto[indexTag].tag = indexTag
        }
    }

    /// addGestureToPhotoContainerView
    private func addSwipeGestureToPhotoContainer() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeUp.direction = .up
        let swipeLeft =  UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swipeLeft.direction = .left
        photoContainer.addGestureRecognizer(swipeUp)
        photoContainer.addGestureRecognizer(swipeLeft)
    }

    /// smooth it out the photoContainer and subviews
    private func initializeViewContainer() {
        for element in imagePhoto + buttonPhoto {
            element.layer.cornerRadius = 8
            photoContainer.layer.cornerRadius = 10
            layoutViewCase()
        }
    }

    /// hide or show image button selected
    private func layoutViewCase() {
        uiViewPhoto[1].isHidden = typeLayout == .layout1
        imageOfSelected[0].isHidden = typeLayout != .layout1

        uiViewPhoto[2].isHidden = typeLayout == .layout2
        imageOfSelected[1].isHidden = typeLayout != .layout2

        imageOfSelected[2].isHidden = typeLayout != .layout3
    }

    /// animation photoContainer after swipe
    /// - Parameters:
    ///   - axeX: translation to axe X
    ///   - axeY: translation to axe y
    private func animateSwipe(translationX axeX: CGFloat, translationY axeY: CGFloat) {
        UIView.animate(withDuration: 0.8, animations: {
            self.photoContainer.transform = CGAffineTransform(translationX: axeX, y: axeY)
        }) { [self] (completed) in
            if completed {
                self.shareActivityController()
                self.animateBackToCenter()
            }
        }
    }

    /// open user's library photo with imagePicker
    private func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }

    /// send Photo Container View to origine
    private func animateBackToCenter() {
        UIView.animate(withDuration: 0.8, animations: {
            self.photoContainer.transform = .identity
        }, completion: nil)
    }

    /// share photo with UiActivityViewController
    private func shareActivityController() {
        let convertUiView = photoContainer.getImage()
        let image = [convertUiView]
        let activityViewController = UIActivityViewController(activityItems: image as [UIImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - extension imagePicker Delegate
extension PrincipalViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    /// action after image chosen
    /// - Parameters:
    ///   - picker: identify picker used
    ///   - info: image chosen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            if let targetImage = imageSelected {
                targetImage.image = image
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    /// if picker image is cancelled picker dismiss
    /// - Parameter picker: identify picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
