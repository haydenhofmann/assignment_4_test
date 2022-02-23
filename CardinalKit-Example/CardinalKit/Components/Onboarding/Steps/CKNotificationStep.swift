//
//  HealthDataStep.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import HealthKit
import ResearchKit
import CardinalKit

class CKNotificationStep: ORKInstructionStep {
    
    override init(identifier: String) {
        super.init(identifier: identifier)
        
       
        title = "Allow Push Notifications"
        text = "This helps remind you to take your daily EMA Survey"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CKNotificationStepViewController: ORKInstructionStepViewController {
    
    
    override func goForward() {
        let manager = NotificationManager.share
        manager.requestAuthorization() { success,_ in
            
            if success {
                manager.scheduleNotification()
            }
            
            OperationQueue.main.addOperation {
                super.goForward()
            }
        }
    }
}
