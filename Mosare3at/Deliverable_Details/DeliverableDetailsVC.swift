//
//  DeliverableDetailsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/7/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class DeliverableDetailsVC: BaseVC, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var layout: DeliverableDetailsLayout!
    var imagePicker = UIImagePickerController()
    var week: Week!
    var deliverable: Deliverable!
    
    public static func buildVC(week: Week, deliverable: Deliverable) -> DeliverableDetailsVC {
        let vc = DeliverableDetailsVC()
       vc.week = week
        vc.deliverable = deliverable
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout = DeliverableDetailsLayout(superview: self.view, deliverableDetailsLayoutDelegate: self, screenTitle: self.deliverable.title)
        layout.setupViews()
        layout.deliverablesDetailsTableView.delegate = self
        layout.deliverablesDetailsTableView.dataSource = self
        layout.deliverablesDetailsTableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }

}

extension DeliverableDetailsVC: DeliverableDetailsLayoutDelegate {
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retry() {
        
    }
}

extension DeliverableDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deliverable.typeTitle == "فيديو" {
            return self.deliverable.descriptions.count + 2
        } else {
            return self.deliverable.descriptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if deliverable.typeTitle == "فيديو" {
            if indexPath.row == self.deliverable.descriptions.count {
                // return important note
                let cell:ImportantNoteCell = self.layout.deliverablesDetailsTableView.dequeueReusableCell(withIdentifier: ImportantNoteCell.identifier, for: indexPath) as! ImportantNoteCell
                cell.selectionStyle = .none
                cell.setupViews()
                return cell
            } else if indexPath.row == self.deliverable.descriptions.count + 1 {
                // return upload video
                let cell:UploadVideoCell = self.layout.deliverablesDetailsTableView.dequeueReusableCell(withIdentifier: UploadVideoCell.identifier, for: indexPath) as! UploadVideoCell
                cell.selectionStyle = .none
                cell.setupViews()
                cell.delegate = self
                return cell
            } else {
                let cell:DeliverableDetailsCell = self.layout.deliverablesDetailsTableView.dequeueReusableCell(withIdentifier: DeliverableDetailsCell.identifier, for: indexPath) as! DeliverableDetailsCell
                cell.selectionStyle = .none
                cell.describtion = self.deliverable.descriptions.get(at: indexPath.row)!
                cell.setupViews()
                cell.populateData()
                return cell
            }
        } else {
            let cell:DeliverableDetailsCell = self.layout.deliverablesDetailsTableView.dequeueReusableCell(withIdentifier: DeliverableDetailsCell.identifier, for: indexPath) as! DeliverableDetailsCell
            cell.selectionStyle = .none
            cell.describtion = self.deliverable.descriptions.get(at: indexPath.row)!
            cell.setupViews()
            cell.populateData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let string = deliverable.descriptions.get(at: indexPath.row)?.description.byConvertingHTMLToPlainText()
        if deliverable.typeTitle == "فيديو" {
            
            if indexPath.row == self.deliverable.descriptions.count {
                // return important note
                return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 18)
            } else if indexPath.row == self.deliverable.descriptions.count + 1 {
                // return upload video
                return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 22)
            } else {
                return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4) + string!.height(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90), font: AppFont.font(type: .Regular, size: 15), lineBreakMode: NSLineBreakMode.byWordWrapping) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)
            }
        } else {
            return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4) + string!.height(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 90), font: AppFont.font(type: .Regular, size: 15), lineBreakMode: NSLineBreakMode.byWordWrapping) + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 10)
        }
    }
}

extension DeliverableDetailsVC: UploadVideoCellDelegate {
    func cameraVideoIconClicked() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.imagePicker.mediaTypes = [kUTTypeMovie] as [String]
                    self.imagePicker.allowsEditing = false
                    
                    self.imagePicker.showsCameraControls = false
                    
                    self.imagePicker.modalPresentationStyle = .custom
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            } else {
                
            }
        }
    }
    
    func galleryIconClicked() {
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")
                    
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = .savedPhotosAlbum;
                    self.imagePicker.allowsEditing = false
                    
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            } else {
                
            }
        }
    }
}
