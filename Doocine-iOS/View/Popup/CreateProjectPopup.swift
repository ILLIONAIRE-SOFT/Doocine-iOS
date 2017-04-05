//
//  CreateProjectPopup.swift
//  Doocine-iOS
//
//  Created by Sohn on 30/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController
import RealmSwift

class CreateProjectPopup: UIViewController, PopupContentViewController {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var cameraTextField: UITextField!
    @IBOutlet weak var actorTextField: UITextField!
    
    var delegateCreate: ((_ movieStoryboard: MovieStoryboard) -> ())!
    var delegateTappedClose: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initButton()
        // Do any additional setup after loading the view.
    }
    
    private func initButton() -> Void {
        createButton.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tappedClose), for: .touchUpInside)
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        let width = UIScreen.main.bounds.width - 240
        let height: CGFloat = 474 + 36
        return CGSize(width: width, height: height)
    }
}


// MARK: - Tap Action
extension CreateProjectPopup {
    public func tappedCreate() -> Void {
        if !isComplete() {
            print(Constants.PROJECT_CREATE_ERROR)
            return
        }
        
        let realm = try! Realm()
        let storyboards = realm.objects(MovieStoryboard).sorted(byKeyPath: "id")
        print("스토리보드 개수 카운트 \(storyboards.count)")
        let lastId = storyboards.last?.id
        print("마지막 스토리 보드 아디 \(lastId)")
        
        let movieStoryboard = MovieStoryboard()
        movieStoryboard.actor = "Tang Wei"
        movieStoryboard.cameraMan = "DaiGeun Sohn"
        movieStoryboard.director = "감독맨"
        movieStoryboard.group = "앙트시네"
        movieStoryboard.title = "계란맨"
        
        if storyboards.count == 0 {
            movieStoryboard.id = 0
        } else {
            movieStoryboard.id = lastId! + 1
        }
        
        self.delegateCreate!(movieStoryboard)
    }
    
    public func tappedClose() -> Void {
        self.delegateTappedClose!()
    }
}


// MARK: - Check Condition
extension CreateProjectPopup {
    fileprivate func isComplete() -> Bool {
        if titleTextField.text == nil || titleTextField.text == "" {
            return false
        }
        
        if groupTextField.text == nil || groupTextField.text == "" {
            return false
        }
        
        if directorTextField.text == nil || directorTextField.text == "" {
            return false
        }
        
        if cameraTextField.text == nil || cameraTextField.text == "" {
            return false
        }
        
        if actorTextField.text == nil || actorTextField.text == "" {
            return false
        }
        
        return true
    }
}
