//
//  AvatarRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/9/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol AvatarPresenterDelegate {
    func avatarsRetrieved(avatars: [String])
    func avatarRetrieveError(message: String)
    func updateAvatarSuccess(message: String)
    func updateAvatarFailed(message: String)
}

public class AvatarRepository {
    
    var delegate: AvatarPresenterDelegate!
    
    public func setDelegate(delegate: AvatarPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getAvatars() {
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "media/avatar-list")!).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [String] {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                        self.delegate.avatarsRetrieved(avatars: json)
                    } else {
                        self.delegate.avatarsRetrieved(avatars: [])
                    }
                }
            } else {
                self.delegate.avatarRetrieveError(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func updateUserAvatar(imageName: String, userId: Int) {
        
        let user = User.getInstance(dictionary: Defaults[.user]!)
        let headers = ["Content-Type" : "application/json", "X-AUTH-TOKEN" : "\(user.token!)"]
        let parameters = ["profilePic" : imageName]
        
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "users/\(userId)")!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 {
                    self.delegate.updateAvatarSuccess(message: "updateAvatarSuccess".localized())
                    // update the user's profile image using the uploaded one
                    let user = User.getInstance(dictionary: Defaults[.user]!)
                    user.profilePic = imageName
                    Defaults[.user] = user.convertToDictionary()
                } else {
                    self.delegate.updateAvatarFailed(message: "updateAvatarFailed".localized())
                }
            } else {
                self.delegate.updateAvatarFailed(message: "somethingWentWrong".localized())
            }
        }
    }
    
    public func uploadUserImageToServer(imageData: Data) {
        let fileName = "image.png"
        let mimeType = "image/png"
        UiHelpers.showLoader()
        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: mimeType)
        }, to:"\(CommonConstants.BASE_URL)media/upload", method:.post, headers : nil, encodingCompletion: { encodingResult in
                 switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                               if let dictionary = response.value as? Dictionary<String, Any> {
                                    let name = dictionary["name"] as! String
                                    let user = User.getInstance(dictionary: Defaults[.user]!)
                                    self.updateUserAvatar(imageName: name, userId: user.id)
                               } else {
                                    self.delegate.updateAvatarFailed(message: "updateAvatarFailed".localized())
                                }
                            }
                    case .failure(let encodingError):
                        self.delegate.updateAvatarFailed(message: encodingError as! String)
                    }
        })
    }
}
