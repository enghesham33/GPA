//
//  ChooseAvatarVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Foundation
import AVKit

class ChooseAvatarVC: BaseVC {

    var layout : ChooseAvatarLayout!
    var imagePicker = UIImagePickerController()
    var presenter: AvatarPresenter!
    var avatars: [String] = []
    var avatarChoiceSource: AVATAR_CHOICE_SOURCE!
    var choosenAvatarName: String!
    
    static func buildVC() -> ChooseAvatarVC {
        return ChooseAvatarVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = ChooseAvatarLayout(superview: self.view, chooseAvatarDelegate: self)
        layout.setupViews()
        
        showStaticData()
        setupImagesCollectionView()
        
        presenter = Injector.provideAvatarPresenter()
        presenter.setView(view: self)
        presenter.getAvatars()
    }
    
    private func showStaticData() {
        let user = User.getInstance(dictionary: Defaults[.user]!)
        self.layout.welcomeLabel.text = "\("welcome".localized()) \(user.firstName!) \(user.lastName!) \("kwnPlatform".localized())"
       
    }
    
    private func setupImagesCollectionView() {
        self.layout.imagesCollectionView.backgroundColor = .clear
        self.layout.imagesCollectionView.dataSource = self
        self.layout.imagesCollectionView.delegate = self
        self.layout.imagesCollectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.identifier)
        self.layout.imagesCollectionView.showsHorizontalScrollIndicator = false
        if let layout = self.layout.imagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func chooseImageFromGallery() {
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //already authorized
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary;
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        self.imagePicker.delegate = self
                        self.imagePicker.sourceType = .photoLibrary;
                        self.imagePicker.allowsEditing = false
                        self.present(self.imagePicker, animated: true, completion: nil)
                    }
                } else {
                    //access denied
                }
            })
        }
    }
    
    func chooseImageFromAvatars(index: Int) {
        self.layout.choosenAvatarImageview.af_setImage(withURL: URL(string: "\(CommonConstants.BASE_URL)media/download/\(self.avatars.get(at: index)!)")!, placeholderImage: UIImage(named: "placeholder"))
        self.layout.choosenAvatarImageview.backgroundColor = .clear
        self.choosenAvatarName = self.avatars.get(at: index)
        avatarChoiceSource = .FROM_SERVER
    }
    
    func goToProgramScreen() {
        
    }
}

extension ChooseAvatarVC : AvatarView {
    
    func avatarsRetrieved(avatars: [String]) {
        self.avatars = avatars
        self.layout.imagesCollectionView.reloadData()
        let lastItemIndex = IndexPath(item: avatars.count - 1, section: 0)
        self.layout.imagesCollectionView.scrollToItem(at: lastItemIndex, at: UICollectionView.ScrollPosition.right, animated: true)
        self.chooseImageFromAvatars(index: avatars.count - 1)
    }
    
    func avatarRetrieveError(message: String) {
        self.view.makeToast(message)
    }
    
    func updateAvatarSuccess(message: String) {
        self.view.makeToast(message, duration: 2) {
            self.goToProgramScreen()
        }
    }
    
    func updateAvatarFailed(message: String) {
        self.view.makeToast(message)
    }
}

extension ChooseAvatarVC : ChooseAvatarDelegate {
    func updateAvatar() {
        switch self.avatarChoiceSource {
        case .FROM_SERVER?:
            let user = User.getInstance(dictionary: Defaults[.user]!)
            self.presenter.updateUserAvatar(imageName: self.choosenAvatarName, userId: user.id)
            break
            
        case .FROM_GALLERY?:
            self.presenter.uploadUserImageToServer(image: self.layout.choosenAvatarImageview.image!)
            break
        default:
            break
        }
    }
    
    func openGallery() {
        chooseImageFromGallery()
    }
    
    func retry() {
        
    }
}

extension ChooseAvatarVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        picker.dismiss(animated: true, completion: { () -> Void in
            self.layout.choosenAvatarImageview.image = image
            self.layout.choosenAvatarImageview.backgroundColor = .clear
            self.avatarChoiceSource = .FROM_GALLERY
        })
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { () -> Void in
            print("cancelled")
        })
    }
}

extension ChooseAvatarVC : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.identifier, for: indexPath) as! AvatarCell
        cell.delegate = self
        cell.raduis = UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30
        )
        cell.setupViews()
        cell.populateImage(imageName: self.avatars.get(at: indexPath.row)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemRauis = Double(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 30))
        return CGSize(width: CGFloat(itemRauis) , height: CGFloat(itemRauis))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // between each row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 //between item in row
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chooseImageFromAvatars(index: indexPath.row)
    }
}

extension ChooseAvatarVC : ChooseImageDelegat {
    func chooseImage(image: UIImage, imageName: String) {
        self.layout.choosenAvatarImageview.image = image
        self.layout.choosenAvatarImageview.backgroundColor = .clear
         avatarChoiceSource = .FROM_SERVER
        self.choosenAvatarName = imageName
    }
}

public enum AVATAR_CHOICE_SOURCE : Int {
    case FROM_SERVER = 0
    case FROM_GALLERY = 1
}
