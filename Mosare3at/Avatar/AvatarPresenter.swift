//
//  AvatarPresenter.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/9/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol AvatarView : class {
    func avatarsRetrieved(avatars: [String])
    func avatarRetrieveError(message: String)
    func updateAvatarSuccess(message: String)
    func updateAvatarFailed(message: String)
}

public class AvatarPresenter {
    fileprivate weak var avatarView : AvatarView?
    fileprivate let avatarRepository : AvatarRepository
    
    init(repository: AvatarRepository) {
        self.avatarRepository = repository
        self.avatarRepository.setDelegate(delegate: self)
    }
    
    // this initialize the presenter view methods
    func setView(view : AvatarView) {
        avatarView = view
    }
}

extension AvatarPresenter {
    public func getAvatars() {
        UiHelpers.showLoader()
        self.avatarRepository.getAvatars()
    }
    
    public func updateUserAvatar(imageName: String, userId: Int) {
        UiHelpers.showLoader()
        self.avatarRepository.updateUserAvatar(imageName: imageName, userId: userId)
    }
    
    public func uploadUserImageToServer(image: UIImage) {
        self.avatarRepository.uploadUserImageToServer(imageData: image.jpeg(.lowest)!)
    }
    
}

extension AvatarPresenter : AvatarPresenterDelegate {
    public func updateAvatarSuccess(message: String) {
        UiHelpers.hideLoader()
        self.avatarView?.updateAvatarSuccess(message: message)
    }
    
    public func updateAvatarFailed(message: String) {
        UiHelpers.hideLoader()
        self.avatarView?.updateAvatarFailed(message: message)
    }
    
    public func avatarsRetrieved(avatars: [String]) {
        UiHelpers.hideLoader()
        self.avatarView?.avatarsRetrieved(avatars: avatars)
    }
    
    public func avatarRetrieveError(message: String) {
        UiHelpers.hideLoader()
        self.avatarView?.avatarRetrieveError(message: message)
    }
}
