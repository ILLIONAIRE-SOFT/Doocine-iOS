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
    
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var makeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Stroyboard Id : \(self.storyboardId!)")
        initNavigation()
        initButton()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "Make Scene")
    }
    
    private func initButton() -> Void {
        self.makeButton.addTarget(self, action: #selector(makeScene), for: .touchUpInside)
    }
    
    public func makeScene() -> Void {
        if placeTextField.text == "" || placeTextField.text == nil {
            print("장소를 입력하세요.")
            return
        }
        
        if timeTextField.text == "" || timeTextField.text == nil {
            print("시간을 입력하세요.")
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
}
