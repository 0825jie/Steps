//
//  HealthKitSetup.swift
//  Steps
//
//  Created by jason on 2019/4/23.
//  Copyright © 2019年 jason. All rights reserved.
//

import HealthKit

class HealthKitSetUp {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        guard
            let step = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                completion(false, HealthkitSetupError.dataTypeNotAvailable)
                return
        }
        
        let healthKitTypesToRead: Set<HKObjectType> = [step]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToRead as! Set<HKSampleType>,
                                             read: healthKitTypesToRead) { (success, error) in
                                                completion(success, error)
        }
    }
    
    static func checkAuthorized() -> Bool {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            return false
        }
        
        if let type = HKObjectType.quantityType(forIdentifier: .stepCount) {
            let healthKitTypesToRead: HKObjectType = type
            
            let healthStore = HKHealthStore()
            let authorizationStatus = healthStore.authorizationStatus(for: healthKitTypesToRead)

            switch authorizationStatus {
            case HKAuthorizationStatus.sharingAuthorized: return true
             case .sharingDenied: return false
            default: return false
            }
        }
        return false
    }
    
    
    
}
