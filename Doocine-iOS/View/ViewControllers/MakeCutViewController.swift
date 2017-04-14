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
    
    var sceneId: Int!
    @IBOutlet weak var shotSizeValueLabel: UILabel!
    @IBOutlet weak var cameraWalkValueLabel: UILabel!
    @IBOutlet weak var dialogTextField: UITextField!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var cutImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var pickedPhoto = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initViews()
        initButton()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "Make Cut")
    }
    
    private func initViews() -> Void {
        self.shotSizeValueLabel.isUserInteractionEnabled = true
        self.cameraWalkValueLabel.isUserInteractionEnabled = true
        
        let tapShotSize = UITapGestureRecognizer(target: self, action: #selector(tappedSelectShotSize))
        shotSizeValueLabel.addGestureRecognizer(tapShotSize)
        
        let tapCameraWalk = UITapGestureRecognizer(target: self, action: #selector(tappedSelectCameraWalk))
        cameraWalkValueLabel.addGestureRecognizer(tapCameraWalk)
        
        imagePicker.delegate = self
        
        cutImage.isUserInteractionEnabled = true
        
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
        cutImage.addGestureRecognizer(tapImage)
        cutImage.contentMode = .scaleAspectFit
        cutImage.clipsToBounds = true
    }
    
    private func initButton() -> Void {
        makeButton.clipsToBounds = true
        makeButton.layer.cornerRadius = 8
        
        makeButton.addTarget(self, action: #selector(makeCut), for: .touchUpInside)
    }
    
    public func makeCut() -> Void {
        if dialogTextField.text == "" || dialogTextField.text == nil {
            print("메세지를 입력하세요.")
            return
        }
        
        // 이미지 선택됬는지 확인
        
        let cut = Cut()
        
        let realm = try! Realm()
        let cuts = realm.objects(Cut.self).sorted(byKeyPath: "id")
        let lastId = cuts.last?.id
        
        if cuts.count == 0 {
            cut.id = 0
        } else {
            cut.id = lastId! + 1
        }
        
        cut.sceneId = self.sceneId
        cut.cameraWalkMode = cameraWalkValueLabel.text
        cut.shotSize = shotSizeValueLabel.text
        cut.dialog = dialogTextField.text
        
        try! realm.write {
            realm.add(cut)
        }
        
        self.navigationController?.popViewController(animated: true)
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
        }
        
        popup.didShowHandler { (_) in
        }
        
        popup.didCloseHandler { (_) in
        }
        
        popup = popup.show(controller)
    }
    
    func tappedImage() -> Void {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}


// MARK: - Image Picker Delegate
extension MakeCutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = (info[UIImagePickerControllerEditedImage] as? UIImage)
        
        if image != nil {
            self.pickedPhoto = image!
            self.cutImage.image = pickedPhoto
//            isPhotoPicked = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
