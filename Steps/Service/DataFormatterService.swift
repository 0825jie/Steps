//
//  DataFormatter.swift
//  Steps
//
//  Created by jason on 2019/4/24.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

class DataFormatterService {
    
    static func getWeekDay(day: Date) -> String{

        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        var str = formatter.string(from: day)
        return str
    }
    
    static func getDate(day: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        var str = formatter.string(from: day)
        return str
    }
}
