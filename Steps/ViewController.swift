//
//  ViewController.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var authBtn: UIButton = {
        var btn = UIButton()
        btn.setTitleColor(UIColor(red: 0.2667, green: 0.1804, blue: 0.149, alpha: 1.0), for: .normal)
        btn.layer.cornerRadius = 15
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor(red: 1, green: 0.4667, blue: 0, alpha: 1.0)
        return btn
    }()
    
    var startBtn:  UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor(red: 0.2667, green: 0.1804, blue: 0.149, alpha: 1.0), for: .normal)
        btn.layer.borderColor = UIColor.clear.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = UIColor(red: 1, green: 0.4667, blue: 0, alpha: 1.0)
        btn.isHidden = true
        return btn
    }()
    
    var authInfo: UILabel = {
        let label = UILabel()
        label.text = "*HealthKit authorized."
        label.font = label.font.withSize(13)
        label.isHidden = true
        return label
    }()
    
    var backgroundPic: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: 0.5098, green: 0.5686, blue: 0.6078, alpha: 1.0)
        return img
    }()

    override func viewWillAppear(_ animated: Bool) {
        checkStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func checkStatus() {
        if HealthKitSetUp.checkAuthorized() {
            update()
        }
    }
    
    fileprivate func setupView(){
      
        view.addSubview(backgroundPic)
        
        backgroundPic.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: view.frame.width, height: 0)
        authBtn.setTitle("Authorization", for: .normal)
        startBtn.setTitle("Start", for: .normal)
        
        view.addSubview(authBtn)
        view.addSubview(startBtn)

        authBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: (view.frame.height - 120)/2, leftPadding: (view.frame.width - 200)/2, bottomPadding: 0, rightPadding: (view.frame.width - 200)/2, width: 0, height: 60)
        
        startBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: (view.frame.height - 120)/2, leftPadding: (view.frame.width - 200)/2, bottomPadding: 0, rightPadding: (view.frame.width - 200)/2, width: 0, height: 60)
        
        view.addSubview(authInfo)
        authInfo.anchor(top: startBtn.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topPadding: 4, leftPadding: (view.frame.width - 200)/2, bottomPadding: 0, rightPadding: 0, width: 200, height: 20)

        authBtn.addTarget(self, action: #selector(authorizeHealthKit), for: .allTouchEvents)
        startBtn.addTarget(self, action: #selector(handleStart), for: .allTouchEvents)
    }
    
    @objc fileprivate func handleStart(){
        
        let nextPage = StepsViewController()
        present(nextPage, animated: true)
    }
    
    
    
    @objc private func authorizeHealthKit() {
        
        HealthKitSetUp.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            DispatchQueue.main.async {
                 self.update()
            }
        }
        
    }
    
    func update(){
        authBtn.removeFromSuperview()
        authInfo.isHidden = false
        startBtn.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}

