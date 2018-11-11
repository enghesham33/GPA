//
//  WeekDetailsRepository.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults

public protocol WeekDetailsPresenterDelegate {
    func opetaionFailed(message: String)
    func getWeekMaterialSuccess(weekMaterials: [WeekMaterial])
}

public class WeekDetailsRepository {
    var delegate: WeekDetailsPresenterDelegate!
    
    public func setDelegate(delegate: WeekDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getWeekMaterials(weekId: Int) {
        let headers = ["X-AUTH-TOKEN" : Defaults[.token]!]
        let params = ["week":weekId]
        Alamofire.request(URL(string: CommonConstants.BASE_URL + "week_materials")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            UiHelpers.hideLoader()
            if response.result.isSuccess {
                if let json = response.result.value as? Dictionary<String,AnyObject> {
                    if response.response?.statusCode == 200 ||  response.response?.statusCode == 201 || response.response?.statusCode == 204 {
                        let jsonArray = json["hydra:member"] as? [Dictionary<String,AnyObject>]
                        var weekMaterials = [WeekMaterial]()
                        for dic in jsonArray! {
                            let weekMaterial = WeekMaterial.getInstance(dictionary: dic)
                            weekMaterials.append(weekMaterial)
                        }
                        self.delegate.getWeekMaterialSuccess(weekMaterials: weekMaterials)
                    } else {
//                        let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                        self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                    }
                } else {
//                    let jsonObj = response.result.value as? Dictionary<String,AnyObject>
                    self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
                }
            } else {
                self.delegate.opetaionFailed(message: "somethingWentWrong".localized())
            }
        }
    }
}


