//
//  CalculateDateService.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import UIKit
import Foundation
import HealthKit

class GetStepsService: HKQuery {

    
    var stepsCollection = [Step]()
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    static let shared = GetStepsService("")
    
    private init(_ name: String) {
        
    }

    func getCollection(page: Int, completion: @escaping (_ result: [Step], _ error: String?)-> Void){
        let calendar = NSCalendar.current
        let interval = NSDateComponents()
        interval.day = 1
        let now = Date()
        let today = calendar.startOfDay(for: now)
        var components = DateComponents()
        components.day = 1
        let todayend = calendar.date(byAdding: components, to: today)
        
        let startDay = Calendar.current.date(byAdding: .hour, value: 7*(page - 1)*24, to: todayend!)
        let endDay = Calendar.current.date(byAdding: .hour, value: 7*(page)*24, to: todayend!)
        
        let anchorDate = today
        let predicate = HKQuery.predicateForSamples(withStart: startDay, end: endDay, options: .strictEndDate)

        let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!

        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: anchorDate,
                                                intervalComponents: interval as DateComponents)
        query.initialResultsHandler = {
            query, results, error in
            guard let statsCollection = results else {
                completion([Step](), error?.localizedDescription)
                fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
            }
            if statsCollection.statistics().count == 0 {
                completion([Step](), "No Data for this period")
                return
            }
                self.stepsCollection.removeAll()
                var max = 0
                for item in statsCollection.statistics() {
                    let weekday = DataFormatterService.getWeekDay(day: item.startDate)
                    let date = DataFormatterService.getDate(day: item.startDate)
                    let val = Int(item.sumQuantity()!.doubleValue(for:  HKUnit.count()))
                    max = max > val ? max : val
                    let curStep = Step(weekday: weekday, date: date, count: val, weekMax: max)
                    self.stepsCollection.append(curStep)

                }
                    completion(self.stepsCollection, nil)
        }
        
         healthStore?.execute(query)
    }
}
