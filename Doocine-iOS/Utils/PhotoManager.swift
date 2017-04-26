//
//  PhotoManager.swift
//  Doocine-iOS
//
//  Created by Sohn on 16/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class PhotoManager: NSObject {
    private static func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
    
    public static func saveImage(image: UIImage, imageId: Int, isSecondImage: Bool = false) -> Void {
        let pngImageData = UIImagePNGRepresentation(image)
        
        var fileURL = getDocumentsURL()
        
        if isSecondImage {
            fileURL = fileURL.appendingPathComponent("\(String(imageId))-2")
        } else {
            fileURL = fileURL.appendingPathComponent("\(String(imageId))")
        }
        
        do {
            try pngImageData?.write(to: fileURL)
            print("Save success")
        } catch let error {
            print(error)
        }
    }
    
    public static func loadImage(imageId: Int, isSecondImage: Bool = false) -> UIImage? {
        var fileURL = getDocumentsURL()
        
        if isSecondImage {
            fileURL = fileURL.appendingPathComponent("\(String(imageId))-2")
        } else {
            fileURL = fileURL.appendingPathComponent("\(String(imageId))")
        }
        
        let image = UIImage(contentsOfFile: fileURL.path)
        
        if image == nil {
            print("missing image at: \(fileURL.path)")
        }
        print("Loading image from path: \(fileURL.path)")
        return image
    }
    
    public static func deleteImage(imageId: Int) -> Void {
        // 사진 두 개 다 삭제시켜줘야한다.
        let pngImagePath = getDocumentsURL().appendingPathComponent(String(imageId))
        let secondImagePath = getDocumentsURL().appendingPathComponent("\(String(imageId))-2")
        
        do {
            try FileManager.default.removeItem(at: pngImagePath)
        } catch _ as NSError {
            print("File not exist")
        }
        
        do {
            try FileManager.default.removeItem(at: secondImagePath)
        } catch _ as NSError {
            print("File not exist")
        }
    }
}
