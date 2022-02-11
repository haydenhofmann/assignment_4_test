//
//  PainSurvey.swift
//  CardinalKit_Example
//
//  Created by Hayden hofmann on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit

struct PainSurvey {
    
    static let painSurvey: ORKOrderedTask = {
        var steps = [ORKStep]()
        let answerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 0, defaultValue: 5, step: 1, vertical: false, maximumValueDescription: "A lot", minimumValueDescription: "a little")
        let painSurveyStep = ORKQuestionStep(identifier: "painSurvey", title: "pain", question: "how much pain are you having?", answer: answerFormat)
        let surveyTasks = ORKOrderedTask(identifier: "painSurvey", steps: [painSurveyStep])
        
        steps += [painSurveyStep]
        
        return ORKOrderedTask(identifier: "painTask", steps: steps)
        
    }()
    
    
    
}
