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
    
    static func buildVC() -> ChooseAvatarVC {
        return ChooseAvatarVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = ChooseAvatarLayout(superview: self.view, chooseAvatarDelegate: self)
        layout.setupViews()
        
        showStaticData()
    }
    
    private func showStaticData() {
        let user = User.getInstance(dictionary: Defaults[.user]!)
        self.layout.welcomeLabel.text = "\("welcome".localized()) \(user.firstName!) \(user.lastName!) \("kwnPlatform".localized())"
        self.layout.imagesCollectionView.backgroundColor = .clear
//        self.layout.imagesCollectionView.dataSource = self
//        self.layout.imagesCollectionView.delegate = self
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
}

extension ChooseAvatarVC : ChooseAvatarDelegate {
    func openGallery() {
        chooseImageFromGallery()
    }
    
    func goToProgramScreen() {
        
    }
    
    func retry() {
        
    }
}

extension ChooseAvatarVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        picker.dismiss(animated: true, completion: { () -> Void in
            print("image Retreived")
        })
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         print("cancelled")
    }
}

//extension ChooseAvatarVC : UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
