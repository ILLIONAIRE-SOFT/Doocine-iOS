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
    
    public static func saveImage(image: UIImage, imageId: Int) -> Void {
        let pngImageData = UIImagePNGRepresentation(image)
        let fileURL = getDocumentsURL().appendingPathComponent(String(imageId))
        do {
            try pngImageData?.write(to: fileURL)
            print("Save success")
        } catch let error {
            print(error)
        }
    }
    
    public static func loadImage(imageId: Int) -> UIImage? {
        let pngImagePath = getDocumentsURL().appendingPathComponent(String(imageId))
        
        let image = UIImage(contentsOfFile: pngImagePath.path)
        
        if image == nil {
            print("missing image at: \(pngImagePath.path)")
        }
        print("Loading image from path: \(pngImagePath.path)")
        return image
    }
    
    public static func deleteImage(imageId: Int) -> Void {
        // 사진 두 개 다 삭제시켜줘야한다.
        let pngImagePath = getDocumentsURL().appendingPathComponent(String(imageId))
        
        do {
            try FileManager.default.removeItem(at: pngImagePath)
        } catch _ as NSError {
            print("File not exist")
        }
    }
}
