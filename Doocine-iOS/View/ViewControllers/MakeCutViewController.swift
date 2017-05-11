//
//  MakeCutViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 13/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController
import RealmSwift

class MakeCutViewController: BaseViewController {
    
    var isUpdate: Bool = false
    var originCut: Cut!
    var sceneId: Int!
    
    @IBOutlet weak var shotSizeValueLabel: UILabel!
    @IBOutlet weak var cameraWalkValueLabel: UILabel!
    @IBOutlet weak var dialogTextField: UITextField!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cutImage: UIImageView!
    @IBOutlet weak var cutNumberLabel: UILabel!
    @IBOutlet weak var secondCutImage: UIImageView!
    
    @IBOutlet weak var shotSizeDownArrow: UIImageView!
    @IBOutlet weak var cameraWalkDownArrow: UIImageView!
    
    @IBOutlet weak var firstCutImageWidthConst: NSLayoutConstraint!
    @IBOutlet weak var secondCutImageWidthConst: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    var pickedPhoto = UIImage()
    var pickedSecondPhoto = UIImage()
    var isPhotoPicked: Bool = false
    var isSecondPhotoPicked: Bool = false
    var targetImage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        initViews()
        
        if isUpdate {
            self.updateOriginValue()
        } else {
            hideSecondImage(animated: false)
        }
        
        initButton()
        initCutNumber()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "Make Cut")
    }
    
    private func initViews() -> Void {
        self.shotSizeValueLabel.isUserInteractionEnabled = true
        self.cameraWalkValueLabel.isUserInteractionEnabled = true
        self.shotSizeDownArrow.isUserInteractionEnabled = true
        self.cameraWalkDownArrow.isUserInteractionEnabled = true
        
        let tapShotSize = UITapGestureRecognizer(target: self, action: #selector(tappedSelectShotSize))
        shotSizeValueLabel.addGestureRecognizer(tapShotSize)
        
        let tapCameraWalk = UITapGestureRecognizer(target: self, action: #selector(tappedSelectCameraWalk))
        cameraWalkValueLabel.addGestureRecognizer(tapCameraWalk)
        
        let tapShotSizeDownArrow = UITapGestureRecognizer(target: self, action: #selector(tappedSelectShotSize))
        shotSizeDownArrow.addGestureRecognizer(tapShotSizeDownArrow)
        
        let tapCameraWalkDownArrow = UITapGestureRecognizer(target: self, action: #selector(tappedSelectCameraWalk))
        cameraWalkDownArrow.addGestureRecognizer(tapCameraWalkDownArrow)
        
        imagePicker.delegate = self
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
        cutImage.isUserInteractionEnabled = true
        cutImage.addGestureRecognizer(tapImage)
        cutImage.contentMode = .scaleAspectFit
        cutImage.clipsToBounds = true
        
        let tapSecondImage = UITapGestureRecognizer(target: self, action: #selector(tappedSecondImage))
        secondCutImage.isUserInteractionEnabled = true
        secondCutImage.addGestureRecognizer(tapSecondImage)
        secondCutImage.contentMode = .scaleAspectFit
        secondCutImage.clipsToBounds = true
    }
    
    private func updateOriginValue() -> Void {
        self.shotSizeValueLabel.text = self.originCut.shotSize
        self.cameraWalkValueLabel.text = self.originCut.cameraWalkMode
        self.dialogTextField.text = self.originCut.dialog
        
        if let photo = PhotoManager.loadImage(imageId: self.originCut.id) {
            self.pickedPhoto = photo
            isPhotoPicked = true
            self.cutImage.image = photo
        } else {
            self.cutImage.image = UIImage(named: "img_banner_doocine")
        }
        
        if let secondPhoto = PhotoManager.loadImage(imageId: self.originCut.id, isSecondImage: true) {
            self.pickedSecondPhoto = secondPhoto
            isSecondPhotoPicked = true
            self.secondCutImage.image = secondPhoto
        } else {
            self.secondCutImage.image = UIImage(named: "img_banner_doocine")
        }
        
        if self.cameraWalkValueLabel.text == "FIX" {
            hideSecondImage(animated: false)
        } else {
            showSecondImage(animated: false)
        }
    }
    
    private func initCutNumber() -> Void {
        if !isUpdate {
            let realm = try! Realm()
            
            let lastCut = realm.objects(Cut.self).filter("sceneId == \(self.sceneId ?? 0)").sorted(byKeyPath: "cutNumber").last
            let lastNumber = lastCut?.cutNumber
            
            if let number = lastNumber {
                self.cutNumberLabel.text = String(number+1)
            } else {
                self.cutNumberLabel.text = "1"
            }
        } else {
            self.cutNumberLabel.text = String(originCut.cutNumber)
        }
    }
    
    private func initButton() -> Void {
        self.makeButton.clipsToBounds = true
        self.makeButton.layer.cornerRadius = 8
        self.deleteButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = 8
        self.deleteButton.setImage(UIImage(named: "icon_delete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.deleteButton.tintColor = UIColor.orange
        
        if isUpdate {
            self.makeButton.setTitle("Save", for: .normal)
            self.makeButton.addTarget(self, action: #selector(updateCut), for: .touchUpInside)
            self.deleteButton.isHidden = false
            self.deleteButton.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
        } else {
            self.makeButton.setTitle("Make Cut", for: .normal)
            self.makeButton.addTarget(self, action: #selector(makeCut), for: .touchUpInside)
            
            self.deleteButton.isHidden = true
        }
    }
    
    public func makeCut() -> Void {
        if dialogTextField.text == "" || dialogTextField.text == nil {
            self.dodoError("메세지를 입력하세요.")
            return
        }
        let cut = Cut()
        
        let realm = try! Realm()
        let cuts = realm.objects(Cut.self).sorted(byKeyPath: "id")
        let lastId = cuts.last?.id
        
        if cuts.count == 0 {
            cut.id = 0
        } else {
            cut.id = lastId! + 1
        }
        
        cut.cutNumber = Int(self.cutNumberLabel.text!)!
        cut.sceneId = self.sceneId
        cut.cameraWalkMode = cameraWalkValueLabel.text
        cut.shotSize = shotSizeValueLabel.text
        cut.dialog = dialogTextField.text
        
        try! realm.write {
            realm.add(cut)
        }
        
        if isPhotoPicked {
            PhotoManager.saveImage(image: pickedPhoto, imageId: cut.id)
        }
        
        if isSecondPhotoPicked && cut.cameraWalkMode != "FIX" {
            PhotoManager.saveImage(image: pickedSecondPhoto, imageId: cut.id, isSecondImage: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func updateCut() -> Void {
        if dialogTextField.text == "" || dialogTextField.text == nil {
            self.dodoError("메세지를 입력하세요.")
            return
        }
        
        let realm = try! Realm()
        
        let cut = realm.objects(Cut.self).filter("id == \(originCut.id)").first
        
        try! realm.write {
            cut?.cutNumber = Int(self.cutNumberLabel.text!)!
            cut?.sceneId = self.originCut.sceneId
            cut?.cameraWalkMode = cameraWalkValueLabel.text
            cut?.shotSize = shotSizeValueLabel.text
            cut?.dialog = dialogTextField.text
        }
        
        if isPhotoPicked {
            PhotoManager.saveImage(image: pickedPhoto, imageId: (cut?.id)!)
        }
        
        if isSecondPhotoPicked && cut?.cameraWalkMode != "FIX" {
            PhotoManager.saveImage(image: pickedSecondPhoto, imageId: (cut?.id)!, isSecondImage: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func deleteCut() -> Void {
        PhotoManager.deleteImage(imageId: originCut.id)
        
        let realm = try! Realm()
        
        let cut = realm.objects(Cut.self).filter("id == \(self.originCut.id)").first
        
        try! realm.write {
            realm.delete(cut!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - View Change
extension MakeCutViewController {
    public func showSecondImage(animated: Bool = true) -> Void {
        firstCutImageWidthConst = firstCutImageWidthConst.setMultiplier(multiplier: 0.5)
        secondCutImageWidthConst = secondCutImageWidthConst.setMultiplier(multiplier: 0.5)
        cutImage.updateConstraints()
        secondCutImage.updateConstraints()
        
        if animated {
            UIView.animate(withDuration: 1.0) {
                self.cutImage.layoutIfNeeded()
                self.secondCutImage.layoutIfNeeded()
            }
        } else {
            self.cutImage.layoutIfNeeded()
            self.secondCutImage.layoutIfNeeded()
        }
    }
    
    public func hideSecondImage(animated: Bool = true) -> Void {
        firstCutImageWidthConst = firstCutImageWidthConst.setMultiplier(multiplier: 1.0)
        secondCutImageWidthConst = secondCutImageWidthConst.setMultiplier(multiplier: 0.0)
        cutImage.updateConstraints()
        secondCutImage.updateConstraints()
        
        if animated {
            UIView.animate(withDuration: 1.0) {
                self.cutImage.layoutIfNeeded()
                self.secondCutImage.layoutIfNeeded()
            }
        } else {
            self.cutImage.layoutIfNeeded()
            self.secondCutImage.layoutIfNeeded()
        }
    }
}


// MARK: - Tap Action
extension MakeCutViewController {
    public func tappedSelectShotSize() -> Void {
        var popup = PopupController.create(self).customize(
            [.animation(.slideUp),
             .scrollable(false),
             .backgroundStyle(.blackFilter(alpha:0.7)),
             .layout(.center),
             .movesAlongWithKeyboard(true)
            ])
        
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "ShotSizeViewController") as! ShotSizeViewController
        
        controller.delegateSelect = { (selectedSize) in
            print(selectedSize)
            self.shotSizeValueLabel.text = selectedSize
            popup.dismiss()
        }
        
        popup.didShowHandler { (_) in
        }
        
        popup.didCloseHandler { (_) in
        }
        
        popup = popup.show(controller)
    }
    
    public func tappedSelectCameraWalk() -> Void {
        var popup = PopupController.create(self).customize(
            [.animation(.slideUp),
             .scrollable(false),
             .backgroundStyle(.blackFilter(alpha:0.7)),
             .layout(.center),
             .movesAlongWithKeyboard(true)
            ])
        
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "CameraWalkPopup") as! CameraWalkPopup
        
        controller.delegateSelect = { (selectedSize) in
            self.cameraWalkValueLabel.text = selectedSize
            popup.dismiss()
            switch self.cameraWalkValueLabel.text! {
            case "FIX":
                self.hideSecondImage()
                
            default:
                self.showSecondImage()
                
            }
        }
        
        popup.didShowHandler { (_) in
            
        }
        
        popup.didCloseHandler { (_) in
            
        }
        
        popup = popup.show(controller)
    }
    
    public func showPhotoModePopup() -> Void {
        var popup = PopupController.create(self).customize(
            [.animation(.slideUp),
             .scrollable(false),
             .backgroundStyle(.blackFilter(alpha:0.7)),
             .layout(.center),
             .movesAlongWithKeyboard(true)
            ])
        
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "PhotoModePopup") as! PhotoModePopup
        
        // 1: Take Photo, 2: Photo Library
        controller.delegateSelect = { (selectedMode) in
            popup.dismiss()
            
            if selectedMode == 1 {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
//                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        popup.didShowHandler { (_) in
            
        }
        
        popup.didCloseHandler { (_) in
            
        }
        
        popup = popup.show(controller)
    }
    
    public func tappedImage() -> Void {
        self.targetImage = 1
        self.showPhotoModePopup()
    }
    
    public func tappedSecondImage() -> Void {
        self.targetImage = 2
        self.showPhotoModePopup()
    }
    
    public func tappedDelete() -> Void {
        let alert = UIAlertController(title: "", message: "삭제하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive, handler: { (action) in
            self.deleteCut()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - Image Picker Delegate
extension MakeCutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        
        if image != nil {
            if self.targetImage == 1 {
                self.pickedPhoto = image!
                self.cutImage.image = pickedPhoto
                isPhotoPicked = true
            } else {
                self.pickedSecondPhoto = image!
                self.secondCutImage.image = pickedSecondPhoto
                isSecondPhotoPicked = true
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


// NSLayout Exstension
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
