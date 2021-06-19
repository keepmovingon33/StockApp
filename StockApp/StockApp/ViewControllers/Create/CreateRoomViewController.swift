//
//  CreateRoomViewController.swift
//  StockApp
//
//  Created by Sky on 5/20/21.
//

import UIKit

class CreateRoomViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var createRoomView: UIView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomNameTextView: UITextView!
    @IBOutlet weak var roomNameSeparatorView: UIView!
    @IBOutlet weak var roomAvatarImage: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var roomMode: UILabel!
    @IBOutlet weak var notePublicImage: UIImageView!
    @IBOutlet weak var notePublicLabel: UILabel!
    @IBOutlet weak var notePrivateImage: UIImageView!
    @IBOutlet weak var notePrivateLabel: UILabel!
    @IBOutlet weak var noteSecretImage: UIImageView!
    @IBOutlet weak var noteSecretLabel: UILabel!
    @IBOutlet weak var disclaimerView: UIView!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var roomHeaderImage: UIImageView!
    @IBOutlet weak var noteSeparatorView: UIView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var roomAvatarImageView: UIView!
    
    @IBOutlet weak var roomModePublicView: UIView!
    @IBOutlet weak var roomModePrivateView: UIView!
    @IBOutlet weak var roomModeSecretView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupStyling()
        setupBackButton()
    }
    
    private func configure() {
        roomNameLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.roomName, attributes: TextFormatting.blackMediumTitle)
        roomNameTextView.attributedText = NSAttributedString(string: Constants.CreateRoom.roomNamePlaceholder, attributes: TextFormatting.grayValue)
        roomNameSeparatorView.backgroundColor = UIColor.grayColor
        roomAvatarImage.image = #imageLiteral(resourceName: "camera")
        noteLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.note, attributes: TextFormatting.blackMediumTitle)
        noteTextView.attributedText = NSAttributedString(string: Constants.CreateRoom.notePlaceholder, attributes: TextFormatting.grayValue)
        roomMode.attributedText = NSAttributedString(string: Constants.CreateRoom.roomMode, attributes: TextFormatting.blackMediumTitle)
        notePublicImage.image = UIImage(named: "icon_check")
        notePrivateImage.image = UIImage(named: "unselected")
        noteSecretImage.image = UIImage(named: "unselected")
        notePublicLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.roomModePublic, attributes: TextFormatting.lightPurpleValue)
        notePrivateLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.roomModePrivate, attributes: TextFormatting.lightPurpleValue)
        noteSecretLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.roomModeSecret, attributes: TextFormatting.lightPurpleValue)
        disclaimerLabel.attributedText = NSAttributedString(string: Constants.CreateRoom.disclaimer, attributes: TextFormatting.grayValue)
        disclaimerView.backgroundColor = UIColor.lightGrayColor
        roomHeaderImage.image = UIImage(named: "createRoom")
        finishButton.setAttributedTitle(NSAttributedString(string: Constants.CreateRoom.finishButton, attributes: TextFormatting.whiteText), for: .normal)
        noteSeparatorView.backgroundColor = UIColor.grayColor
        finishButton.setGradientBackground()
        title = Constants.CreateRoom.title
        
//        roomAvatarImageView.isUserInteractionEnabled = true
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(selectAvatar(_:)))
        roomAvatarImageView.addGestureRecognizer(tapAvatar)
        
        let tapPublicView = UITapGestureRecognizer(target: self, action: #selector(tapPublicRoom(_:)))
        roomModePublicView.addGestureRecognizer(tapPublicView)
        
        let tapPrivateView = UITapGestureRecognizer(target: self, action: #selector(tapPrivateRoom(_:)))
        roomModePrivateView.addGestureRecognizer(tapPrivateView)
        
        let tapSecretView = UITapGestureRecognizer(target: self, action: #selector(tapSecretRoom(_:)))
        roomModeSecretView.addGestureRecognizer(tapSecretView)
    }

    @IBAction func finishButtonTapped(_ sender: Any) {
        
    }
    
    @objc func tapPublicRoom(_ sender: UITapGestureRecognizer? = nil) {
        resetRoomModeTapped()
        notePublicImage.image = UIImage(named: "icon_check")
    }
    
    @objc func tapPrivateRoom(_ sender: UITapGestureRecognizer? = nil) {
        resetRoomModeTapped()
        notePrivateImage.image = UIImage(named: "icon_check")
    }
    
    @objc func tapSecretRoom(_ sender: UITapGestureRecognizer? = nil) {
        resetRoomModeTapped()
        noteSecretImage.image = UIImage(named: "icon_check")
    }
    
    private func resetRoomModeTapped() {
        notePublicImage.image = UIImage(named: "unselected")
        notePrivateImage.image = UIImage(named: "unselected")
        noteSecretImage.image = UIImage(named: "unselected")
    }
    
    // Image Picker
    @objc func selectAvatar(_ sender: UITapGestureRecognizer? = nil) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    // Camera image picker functionality
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Gallery image picker functionality:
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // ImagePicker delegate
    
    func setupStyling() {
        createRoomView.setBorderRadius(with: 8)
        createRoomView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        borderView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        
        finishButton.setBorderRadius(with: 8)
        roomAvatarImageView.setBorderRadius(with: 8)
        
    }
    
}

extension CreateRoomViewController: UIImagePickerControllerDelegate {
    // ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            roomAvatarImage.contentMode = .scaleToFill
            roomAvatarImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
