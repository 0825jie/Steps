//
//  Cell.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

class StepsTableViewCell: UITableViewCell{
    
//    var step: Step?{
//        didSet{
//            weekday.text = step?.date
//            step_num.text = "\(step?.count)"
//        }
//    }
    
    var weekday : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var date : UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = label.font.withSize(12)
    return label
    }()
    
    var step_title : UILabel = {
        let label = UILabel()
        label.text = "steps"
        label.font = label.font.withSize(10)
        return label
    }()
    
    var step_num : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    var step_total : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
   
    
    var bar : UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(red: 1, green: 0.4667, blue: 0, alpha: 1.0)
        vi.layer.cornerRadius = 5
        return vi
    }()
    
    var totalLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = label.font.withSize(18)
        return label
    }()
    
    var weekMax: Int?
    
    var constrain: NSLayoutConstraint?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    fileprivate func setupView(){
        backgroundColor = UIColor(red: 0.9333, green: 0.9294, blue: 0.9059, alpha: 1.0)
        addSubview(weekday)
        weekday.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 16, bottomPadding: 0, rightPadding: 0, width: frame.width*0.15, height: 0)
        
        addSubview(totalLabel)
        totalLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 8, leftPadding: 32, bottomPadding: 8, rightPadding: 0, width: frame.width*0.15, height: 0)
        
        
        addSubview(date)
        date.anchor(top: weekday.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 8, leftPadding: 16, bottomPadding: 8, rightPadding: 0, width: frame.width*0.15, height: 0)
        
        addSubview(bar)
        
        bar.anchor(top: topAnchor, left: weekday.rightAnchor, bottom: bottomAnchor, right: nil, topPadding: frame.height * 0.4, leftPadding: 8, bottomPadding: frame.height * 0.4, rightPadding: 0, width: 0, height: 0)
        constrain = bar.widthAnchor.constraint(equalToConstant: 0)
        constrain?.isActive = true
        
        
        addSubview(step_num)
        step_num.anchor(top: topAnchor, left: bar.rightAnchor, bottom: bottomAnchor, right: nil, topPadding: 10, leftPadding: 8, bottomPadding: 10, rightPadding: 0, width: 100, height: 0)
        
//        addSubview(step_title)
//        step_title.anchor(top: topAnchor, left: step_num.rightAnchor, bottom: bottomAnchor, right: nil, topPadding: 10, leftPadding: 8, bottomPadding: 10, rightPadding: 10, width: 40, height: 0)
//
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with step: Step?, max len: Int) {
        if let step = step {
            weekday.text = step.weekday
            step_num.text = String(step.count)
            weekMax = len
            date.text = step.date
            
            if let cons = constrain {
                 cons.isActive = false
            }
            constrain = bar.widthAnchor.constraint(equalToConstant: (CGFloat(Int(frame.width*0.6)*Int(step_num.text!)!/weekMax!)))
            constrain?.isActive = true
            
           
//            addSubview(weekday)
//            weekday.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 16, bottomPadding: 0, rightPadding: 0, width: frame.width*0.15, height: 0)
//
//            addSubview(date)
//            date.anchor(top: weekday.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 8, leftPadding: 16, bottomPadding: 8, rightPadding: 0, width: frame.width*0.15, height: 0)
//
//            addSubview(bar)
//            bar.anchor(top: topAnchor, left: weekday.rightAnchor, bottom: bottomAnchor, right: nil, topPadding: frame.height * 0.4, leftPadding: 8, bottomPadding: frame.height * 0.4, rightPadding: 0, width: (CGFloat(Int(frame.width*0.6)*Int(step_num.text!)!/weekMax!)), height: 0)
//
//            addSubview(step_num)
//            step_num.anchor(top: topAnchor, left: bar.rightAnchor, bottom: bottomAnchor, right: nil, topPadding: 10, leftPadding: 8, bottomPadding: 10, rightPadding: 0, width: 100, height: 0)
//
        }
    }
    
   
    
}
