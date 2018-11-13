//
//  NotificationsSettingsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import Material
import SwiftyUserDefaults

class NotificationsSettingsVC: BaseVC {

    var layout: NotificationsSettingsLayout!
    
    public static func buildVC() -> NotificationsSettingsVC {
        let vc = NotificationsSettingsVC()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = NotificationsSettingsLayout(superview: self.view, delegate: self)
        layout.setupViews()
        
        populateData()
        
        layout.weekSummarySwitch.delegate = self
        layout.newPointsSwitch.delegate = self
        layout.newBadgeSwitch.delegate = self
        layout.projectStartSwitch.delegate = self
        layout.deadLineSwitch.delegate = self
        layout.deliverableAcceptedSwitch.delegate = self
        layout.deliverableRefusedSwitch.delegate = self
        layout.teamDataUpdatedSwitch.delegate = self
        layout.gotCertificateSwitch.delegate = self
        layout.newVideosSwitch.delegate = self
    }
    
    func populateData() {
        if Defaults[.isWeekSummary]! {
            layout.weekSummarySwitch.setSwitchState(state: .on)
        } else {
            layout.weekSummarySwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isNewPoints]! {
            layout.newPointsSwitch.setSwitchState(state: .on)
        } else {
            layout.newPointsSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isNewBadges]! {
            layout.newBadgeSwitch.setSwitchState(state: .on)
        } else {
            layout.newBadgeSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isProjectStart]! {
            layout.projectStartSwitch.setSwitchState(state: .on)
        } else {
            layout.projectStartSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isDeadLine]! {
            layout.deadLineSwitch.setSwitchState(state: .on)
        } else {
            layout.deadLineSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isDeliverableAccepted]! {
            layout.deliverableAcceptedSwitch.setSwitchState(state: .on)
        } else {
            layout.deliverableAcceptedSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isDeliverableRefused]! {
            layout.deliverableRefusedSwitch.setSwitchState(state: .on)
        } else {
            layout.deliverableRefusedSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isTeamDataUpdated]! {
            layout.teamDataUpdatedSwitch.setSwitchState(state: .on)
        } else {
            layout.teamDataUpdatedSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isGotCertificate]! {
            layout.gotCertificateSwitch.setSwitchState(state: .on)
        } else {
            layout.gotCertificateSwitch.setSwitchState(state: .off)
        }
        
        if Defaults[.isNewVideo]! {
            layout.newVideosSwitch.setSwitchState(state: .on)
        } else {
            layout.newVideosSwitch.setSwitchState(state: .off)
        }
    }

}

extension NotificationsSettingsVC: NotificationsSettingsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationsSettingsVC: SwitchDelegate {
    func switchDidChangeState(control: Switch, state: SwitchState) {
        
        var status: Bool = false
        
        switch state {
        case .on:
            status = true
            break
            
        case .off:
            status = false
            break
        default:
            break
        }
        
        switch control {
        case layout.weekSummarySwitch:
            Defaults[.isWeekSummary] = status
            break
            
        case layout.newPointsSwitch:
            Defaults[.isNewPoints] = status
            break
            
        case layout.newBadgeSwitch:
            Defaults[.isNewBadges] = status
            break
            
        case layout.projectStartSwitch:
            Defaults[.isProjectStart] = status
            break
            
        case layout.deadLineSwitch:
            Defaults[.isDeadLine] = status
            break
            
        case layout.deliverableAcceptedSwitch:
            Defaults[.isDeliverableAccepted] = status
            break
            
        case layout.deliverableRefusedSwitch:
            Defaults[.isDeliverableRefused] = status
            break
            
        case layout.teamDataUpdatedSwitch:
            Defaults[.isTeamDataUpdated] = status
            break
            
        case layout.gotCertificateSwitch:
            Defaults[.isGotCertificate] = status
            break
            
        case layout.newVideosSwitch:
            Defaults[.isNewVideo] = status
            break
            
        default:
            break
        }
    }
    
    
}
