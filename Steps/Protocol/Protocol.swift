//
//  Protocol.swift
//  Steps
//
//  Created by jason on 2019/4/24.
//  Copyright © 2019年 jason. All rights reserved.
//

import Foundation

protocol StepUpdateDelegate: class {
    func finishFetchData()
    func failFetchData(error: String)
    func fetchPre()
    func fetchNext()
    func reOrder()
}
