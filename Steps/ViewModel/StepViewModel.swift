//
//  Cell.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit

final class StepViewModel {
    var steps : [Step]?
    private var curPage = 0
    var isFetchingData = false
    weak var delegate: StepUpdateDelegate?
    var maxStep: Int?
    var acsOrder = true
    
    init() {
       self.curPage = 0
       steps = [Step]()
        maxStep = 0
    }
    
    func fetchData() {
        self.fetchData(page: curPage)
    }
    
    func fetchData(page: Int){
       
        let instance = GetStepsService.shared
        instance.getCollection(page: page) { (result, error) in
            
            if let error = error {
                
                DispatchQueue.main.async {
                    self.delegate?.failFetchData(error: error)
                }
                return
            }
            
            self.curPage = page
            self.steps = result
            self.maxStep = result.last?.weekMax
            self.order()
            
            DispatchQueue.main.async {
                self.delegate?.finishFetchData()
            }

        }

    }
    
    func getCurPage() -> Int{
        return curPage
    }
    
    func getPrePage(){
        fetchData(page: curPage - 1)
    }
    
    func getNextPage(){
        fetchData(page: curPage + 1)
    }
    
    func getTotalSteps() -> Int {
        var res = 0
        guard let steps = steps else {
            return 0
        }
        
        for step in steps {
            res += step.count
        }
        return res
    }
    
    func getTotalCount() -> Int{
        guard let steps = steps else{
             return 0
        }
        return steps.count
    }
    
    func acs(s1:Step, s2:Step) -> Bool {
        return s1.date < s2.date
    }
    
    func des(s1:Step, s2:Step) -> Bool {
        return s1.date > s2.date
    }
    
    func reOrder() {
        if acsOrder {
            steps = steps?.sorted(by: des)
            acsOrder = false
        } else {
            acsOrder = true
            steps = steps?.sorted(by: acs)
        }
       
    }
    
    func order() {
        if acsOrder {
            steps = steps?.sorted(by: acs)
        } else {
            steps = steps?.sorted(by: des)
        }
    }
   
    
    
}
