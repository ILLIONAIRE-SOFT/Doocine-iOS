//
//  MakeSceneViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 13/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import RealmSwift

class MakeSceneViewController: BaseViewController {
    var storyboardId: Int!
    var originalScene: Scene!
    var isUpdate: Bool = false
    
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        initButton()
        
        if isUpdate {
            self.updateOriginalValue()
        }
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "Make Scene")
    }
    
    private func initButton() -> Void {
        if isUpdate {
            deleteButton.isHidden = false
            deleteButton.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
            makeButton.setTitle("Save", for: .normal)
            self.makeButton.addTarget(self, action: #selector(updateScene), for: .touchUpInside)
        } else {
            deleteButton.isHidden = true
            makeButton.setTitle("Make", for: .normal)
            self.makeButton.addTarget(self, action: #selector(makeScene), for: .touchUpInside)
        }
    }
    
    private func updateOriginalValue() -> Void {
        self.placeTextField.text = originalScene.place
        self.timeTextField.text = originalScene.time
    }
    
    public func makeScene() -> Void {
        if placeTextField.text == "" || placeTextField.text == nil {
            self.dodoError("장소를 입력하세요.")
            return
        }
        
        if timeTextField.text == "" || timeTextField.text == nil {
            self.dodoError("시간을 입력하세요.")
            return
        }
        
        let scene = Scene()
        
        let realm = try! Realm()
        let scenes = realm.objects(Scene.self).sorted(byKeyPath: "id")
        let lastId = scenes.last?.id
        
        if scenes.count == 0 {
            scene.id = 0
        } else {
            scene.id = lastId! + 1
        }
        
        scene.storyboardId = self.storyboardId
        
        scene.place = placeTextField.text
        scene.time = timeTextField.text
        scene.cutCount = 0
        
        try! realm.write {
            realm.add(scene)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func updateScene() -> Void {
        if placeTextField.text == "" || placeTextField.text == nil {
            self.dodoError("장소를 입력하세요.")
            return
        }
        
        if timeTextField.text == "" || timeTextField.text == nil {
            self.dodoError("시간을 입력하세요.")
            return
        }
        
        let realm = try! Realm()
        
        let scene = realm.objects(Scene.self).filter("id == \(self.originalScene.id)").first
        
        try! realm.write {
            scene?.place = placeTextField.text
            scene?.time = timeTextField.text
            scene?.cutCount = 0
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    public func tappedDelete() -> Void {
        let alert = UIAlertController(title: "", message: "삭제하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive, handler: { (action) in
            self.deleteScene()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func deleteScene() -> Void {
        let realm = try! Realm()
        
        let cuts = realm.objects(Cut.self).filter("sceneId == \(self.originalScene.id)")
        
        for cut in cuts {
            PhotoManager.deleteImage(imageId: cut.id)
            
            try! realm.write {
                realm.delete(cut)
            }
        }
        
        let scene = realm.objects(Scene.self).filter("id == \(self.originalScene.id)").first
        
        try! realm.write {
            realm.delete(scene!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
