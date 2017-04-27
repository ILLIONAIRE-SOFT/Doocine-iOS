//
//  PhotoModePopup.swift
//  Doocine-iOS
//
//  Created by Sohn on 26/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import PopupController

class PhotoModePopup: UIViewController, PopupContentViewController {
    
    var delegateSelect: ((_ selectedMode: Int) -> ())!
    var itemWidth: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let takePhotoImage = UIImageView()
        takePhotoImage.image = UIImage(named: "icon_take_photo")
        takePhotoImage.contentScaleFactor = 1.0
//        takePhotoImage.contentMode = .scaleAspectFill
        takePhotoImage.clipsToBounds = true
        takePhotoImage.layer.cornerRadius = 8
        takePhotoImage.layer.borderWidth = 0.5
        takePhotoImage.isUserInteractionEnabled = true
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(tappedTakePhoto))
        
        takePhotoImage.addGestureRecognizer(tapTakePhoto)
        
        self.view.addSubview(takePhotoImage)
        
        takePhotoImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(24)
            make.top.equalTo(self.view).offset(24)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        let takePhotoLabel = UILabel()
        takePhotoLabel.text = "Take Photo"
        takePhotoLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(takePhotoLabel)
        
        takePhotoLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(takePhotoImage)
            make.bottom.equalTo(self.view).offset(-24)
        }
        
        let photoLibraryImage = UIImageView()
        photoLibraryImage.image = UIImage(named: "icon_photo_library")
        photoLibraryImage.clipsToBounds = true
        photoLibraryImage.layer.cornerRadius = 8
        photoLibraryImage.layer.borderWidth = 0.5
        photoLibraryImage.isUserInteractionEnabled = true
        
        let tapPhotoLibrary = UITapGestureRecognizer(target: self, action: #selector(tappedLibraryPhoto))
        
        photoLibraryImage.addGestureRecognizer(tapPhotoLibrary)
        
        self.view.addSubview(photoLibraryImage)
        
        photoLibraryImage.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-24)
            make.top.equalTo(self.view).offset(24)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        let photoLibraryLabel = UILabel()
        photoLibraryLabel.text = "Photo Library"
        photoLibraryLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(photoLibraryLabel)
        
        photoLibraryLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(photoLibraryImage)
            make.bottom.equalTo(self.view).offset(-24)
        }
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 300 + 24 + 24 + 24, height: 150 + 24 + 24 + 30)
    }
}


extension PhotoModePopup {
    public func tappedTakePhoto() -> Void {
        if delegateSelect != nil {
            delegateSelect(1)
        }
    }
    
    public func tappedLibraryPhoto() -> Void {
        if delegateSelect != nil {
            delegateSelect(2)
        }
    }
}
