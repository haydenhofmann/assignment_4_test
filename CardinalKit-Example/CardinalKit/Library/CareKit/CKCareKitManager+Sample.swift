//
//  CKCareKitManager+Sample.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore
import Contacts
import UIKit
import FirebaseFirestore

internal extension OCKStore {

    fileprivate func insertDocuments(documents: [DocumentSnapshot]?, collection: String, authCollection: String?,lastUpdateDate: Date?,onCompletion: @escaping (Error?)->Void){
        guard let documents = documents,
             documents.count>0 else {
           onCompletion(nil)
           return
       }
        
        let group = DispatchGroup()
        for document in documents{
            group.enter()
            CKSendHelper.getFromFirestore(authCollection:authCollection, collection: collection, identifier: document.documentID) {(document, error) in
                do{
                    guard let document = document,
                          let payload = document.data(),
                          let id = payload["id"] as? String else {
                              group.leave()
                        return
                    }
                    var itemSchedule:OCKSchedule? = nil
                    var update = true
                    if lastUpdateDate != nil,
                       let updateTimeServer = payload["updateTime"] as? Timestamp,
                       updateTimeServer.dateValue()<lastUpdateDate!{
                        update = false
                    }
                    
                    if update,
                        let schedule = payload["scheduleElements"] as? [[String:Any]]
                    {
                        var scheduleElements=[OCKScheduleElement]()
                        for element in schedule{
                            var startDate = Date()
                            var endDate:Date?=nil
                            var intervalDate = DateComponents(day:2)
                            var durationElement:OCKScheduleElement.Duration = .allDay
                            if let startStamp = element["startTime"] as? Timestamp{
                                startDate = startStamp.dateValue()
                            }
                            if let endStamp = element["endTime"] as? Timestamp{
                                endDate = endStamp.dateValue()
                            }
                            
                            if let interval = element["interval"] as? [String:Any]{
                                var day = 1
                                if let dayInterval = interval["day"] as? Int{
                                    day = dayInterval
                                }
                                var seconds = 1
                                if let secondsInterval = interval["seconds"] as? Int{
                                    seconds = secondsInterval
                                }
                                intervalDate =
                                    DateComponents(
                                        timeZone: interval["timeZone"] as? TimeZone,
                                        year: interval["year"] as? Int,
                                        month: interval["month"] as? Int,
                                        day: day,
                                        hour: interval["hour"] as? Int,
                                        minute: interval["minute"] as? Int,
                                        second: seconds,
                                        weekday: interval["weekday"] as? Int,
                                        weekdayOrdinal: interval["weekdayOrdinal"] as? Int,
                                        weekOfMonth: interval["weekOfMonth"] as? Int,
                                        weekOfYear: interval["weekOfYear"] as? Int,
                                        yearForWeekOfYear: interval["yearForWeekOfYear"] as? Int)
                            }
                            if let duration = element["duration"] as? [String:Any]{
                                if let allDay = duration["allDay"] as? Bool,
                                   allDay{
                                    durationElement = .allDay
                                }
                                if let seconds = duration["seconds"] as? Double{
                                    durationElement = .seconds(seconds)
                                }
                                if let hours = duration["hours"] as? Double{
                                    durationElement = .hours(hours)
                                }
                                if let minutes = duration["minutes"] as? Double{
                                    durationElement = .minutes(minutes)
                                }
                            }
                            var targetValue:[OCKOutcomeValue] = [OCKOutcomeValue]()
                            if let targetValues = element["targetValues"] as? [[String:Any]]{
                                for target in targetValues{
                                    if let identifier = target["groupIdentifier"] as? String{
                                        var come = OCKOutcomeValue(false, units: nil)
                                            come.groupIdentifier=identifier
                                        targetValue.append(come)
                                    }
                                }
                            }
                            scheduleElements.append(OCKScheduleElement(start: startDate, end: endDate, interval: intervalDate, text: element["text"] as? String, targetValues: targetValue, duration: durationElement))
                        }
                        if scheduleElements.count>0{
                            itemSchedule = OCKSchedule(composing: scheduleElements)
                        }
                    }
                    if let itemSchedule = itemSchedule{
                        var uuid:UUID? = nil
                        if let _uuid = payload["uuid"] as? String{
                            uuid=UUID(uuidString: _uuid)
                        }
                        var task = OCKTask(id: id, title: payload["title"] as? String, carePlanUUID: uuid, schedule: itemSchedule)
                        if let impactsAdherence = payload["impactsAdherence"] as? Bool{
                            task.impactsAdherence = impactsAdherence
                        }
                        task.instructions = payload["instructions"] as? String

                        // get if task exist?
                        self.fetchTask(withID: id) { result in
                            switch result {
                                case .failure(_): do {
                                    self.addTask(task)
                                }
                            case .success(_):do {
                                self.updateTask(task)
                                }
                            }

                            group.leave()
                        }
                    }
                    else{
                        group.leave()
                    }
                    
                }
            }
        }
        group.notify(queue: .main, execute: {
            onCompletion(nil)
        })
    }
    // Adds tasks and contacts into the store
    func populateSampleData(lastUpdateDate: Date?,completion:@escaping () -> Void) {
        
        let collection: String = "carekit-store/v2/tasks"
        // Download Tasks By Study
        
        guard  let studyCollection = CKStudyUser.shared.studyCollection else {
            return
        }
        // Get tasks on study
        CKSendHelper.getFromFirestore(authCollection: studyCollection,collection: collection, onCompletion: { (documents,error) in
            self.insertDocuments(documents: documents, collection: collection, authCollection: studyCollection,lastUpdateDate:lastUpdateDate){
                (Error) in
                CKSendHelper.getFromFirestore(collection: collection, onCompletion: { (documents,error) in
                    self.insertDocuments(documents: documents, collection: collection, authCollection: nil,lastUpdateDate:lastUpdateDate){
                        (Error) in
                        self.createContacts()
                        completion()
                    }
                })
            }
        })
        
        //add ResearchKit Survey
        let thisMorning = Calendar.current.startOfDay(for: Date())
        let surveyElement = OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day:1))
        let surveySchedule = OCKSchedule(composing: [surveyElement])
        var survey = OCKTask(id: "EMASurvey", title: "EMA Survey", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = true
        survey.instructions = "Please take this survey in the morning."

        addTask(survey, callbackQueue: .main, completion: nil)
        
        
        
        //add second
        let thisAfternoon = Calendar.current.startOfDay(for: Date())
        let surveyElement2 = OCKScheduleElement(start: thisAfternoon, end: nil, interval: DateComponents(day:1))
        let surveySchedule2 = OCKSchedule(composing: [surveyElement2])
        var survey2 = OCKTask(id: "EMASurvey2", title: "EMA Survey", carePlanUUID: nil, schedule: surveySchedule2)
        survey2.impactsAdherence = true
        survey2.instructions = "Please take this survey in the afternoon"

        addTask(survey2, callbackQueue: .main, completion: nil)
        
        
        //add third
        let thisEvening = Calendar.current.startOfDay(for: Date())
        let surveyElement3 = OCKScheduleElement(start: thisEvening, end: nil, interval: DateComponents(day:1))
        let surveySchedule3 = OCKSchedule(composing: [surveyElement3])
        var survey3 = OCKTask(id: "EMASurvey3", title: "EMA Survey", carePlanUUID: nil, schedule: surveySchedule3)
        survey3.impactsAdherence = true
        survey3.instructions = "Please take this survey in the evening."

        addTask(survey3, callbackQueue: .main, completion: nil)
        

        createContacts()
    }
    
    func createContacts() {
        var contact1 = OCKContact(id: "sean", givenName: "Sean",
                                  familyName: "Mackey", carePlanUUID: nil)
        contact1.asset = "SeanMackey"
        contact1.title = "Chief of the Division of Stanford Pain Medicine"
        contact1.role = "Dr. Mackey is the head of the CHOIR study at Stanford."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "smackey@stanford.edu")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(650) 723-6238")]
        //contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "1070 Arastradero Road"
            address.city = "Palo Alto"
            address.state = "CA"
            address.postalCode = "94304"
            return address
        }()

        addContacts([contact1])
        
        var contact2 = OCKContact(id: "corrine", givenName: "Corrine",
                                  familyName: "Jung", carePlanUUID: nil)
        contact2.asset = "CorrineJung"
        contact2.title = "Division Research Manager"
        contact2.role = "Please feel free to email Dr. Jung with any questions regarding this study."
        contact2.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "cejung@stanford.edu")]
   
        //contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")

        addContacts([contact2])
    }
    
}

extension OCKHealthKitPassthroughStore {

    internal func populateSampleData() {

//        let schedule = OCKSchedule.dailyAtTime(
//            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
//            duration: .hours(12), targetValues: [OCKOutcomeValue(2000.0, units: "Steps")])
//
//        let steps = OCKHealthKitTask(
//            id: "steps",
//            title: "Daily Steps Goal 🏃🏽‍♂️",
//            carePlanUUID: nil,
//            schedule: schedule,
//            healthKitLinkage: OCKHealthKitLinkage(
//                quantityIdentifier: .stepCount,
//                quantityType: .cumulative,
//                unit: .count()))
//
//        addTasks([steps]) { result in
//            switch result {
//            case .success: print("Added tasks into HealthKitPassthroughStore!")
//            case .failure(let error): print("Error: \(error)")
//            }
//        }
    }
}
