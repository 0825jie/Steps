//
//  StepsTableViewHeader.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

class StepsTableViewHeader: UIView{
    weak var delegate: StepUpdateDelegate?

    var leftIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "left")
        return img
    }()
    
    var leftBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "left"), for: .normal)
        return btn
    }()
    
    var rightBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "right"), for: .normal)
        return btn
    }()
    
    var rightIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "right")
        return img
    }()
    
    var totalLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(24)
        return label
    }()
    
    var step_total : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(24)
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView(){
        addSubview(leftBtn)
        leftBtn.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 40, leftPadding: 20, bottomPadding: 40, rightPadding: 0, width: 40, height: 0)
        addSubview(rightBtn)
        rightBtn.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topPadding: 40, leftPadding: 0, bottomPadding: 40, rightPadding: 20, width: 40, height: 0)
        
        leftBtn.addTarget(self, action: #selector(handlePreWeek), for: .allTouchEvents)
        rightBtn.addTarget(self, action: #selector(handleNextWeek), for: .allTouchEvents)
        
    }
    
    func configure(total: Int) {
        totalLabel.text = "Total:"
        step_total.text = String(total) + " steps"
        
        if totalLabel.constraints.count > 0 {
            totalLabel.removeFromSuperview()
        }
        
        addSubview(totalLabel)
        totalLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 8, leftPadding: 60, bottomPadding: 8, rightPadding: 0, width: 56, height: 0)
        
        if step_total.constraints.count > 0 {
            step_total.removeFromSuperview()
        }
        
        addSubview(step_total)
        step_total.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, topPadding: 10, leftPadding: 8, bottomPadding: 10, rightPadding: 60, width: 160, height: 0)
        
        
    }
    
    @objc func handlePreWeek(){
        delegate?.fetchPre()
    }
    
    @objc func handleNextWeek(){
        delegate?.fetchNext()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
