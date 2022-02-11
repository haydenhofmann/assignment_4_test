//
//  EMASurvey.swift
//  CardinalKit_Example
//
//  Created by Sharon Cheng on 2022/1/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit

struct EMASurvey {
    static let emaSurvey : ORKOrderedTask = {
        var steps = [ORKStep]()
        
        // instruction step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Daily Survey"
        instructionStep.text = "Please fill out this survey once a day. There will be questions asking for your pain, sleep, mood, and other relevant experiences that can help doctors to better track your pain."
        steps += [instructionStep]
        
        //Q1: Pain Quantity
        let painScaleAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 0, defaultValue: 5, step: 1, vertical: false, maximumValueDescription: "Extreme pain", minimumValueDescription: "No pain")
        let painScaleQuestionStep = ORKQuestionStep(identifier: "PainScaleQuestionStep", title: "Question #1", question: "Please rate your level of pain right now:", answer: painScaleAnswerFormat)
        steps += [painScaleQuestionStep]
        
        //Q2: Sleep Quality
        let sleepTextChoices = [
            ORKTextChoice(text: "Very Restful", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Somewhat Restful", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Neither Restful nor Restless", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Somewhat Restless", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Very Restless", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let sleepTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sleepTextChoices)
        
        let sleepHourAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        sleepHourAnswerFormat.multipleLines = false
        
        let sleepFormItem = ORKFormItem(identifier: "SleepFormItem1", text: "Overall, how was the quality of your sleep last night:", answerFormat: sleepTextChoiceAnswerFormat)
        let sleepFormItem2 = ORKFormItem(identifier: "SleepFormItem2", text: "How many hours did you sleep last night (input number of hours): ", answerFormat: sleepHourAnswerFormat)
        let sleepFormStep = ORKFormStep(identifier: "SleepFormStep", title: "Question #2", text: "We would now like to ask about your sleep last night.")
        sleepFormStep.formItems = [sleepFormItem, sleepFormItem2]
        sleepFormStep.useCardView = false
        steps += [sleepFormStep]
        
        //Q3: Past experiences
        let activityTextChoices = [
            ORKTextChoice(text: "Working/School work", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Socializing", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Exercising", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Doing leisure activity (e.g., watching tv, using computer or tablet not for work)", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Doing housework (e.g., cooking, cleaning, or other chores)", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Eating", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Sleeping/resting", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Grooming/personal care", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Attending to children (your own or others)", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
            // ask how to do input choice for this one
            ORKTextChoice(text: "Other", value: 9 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let activityTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: activityTextChoices)
        
        let locationTextChoices = [
            ORKTextChoice(text: "Home", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Work", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Driving", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Outdoors", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Restaurant", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Recreational facility (e.g., theater, gym, sporting venue)", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Store", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let locationTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: locationTextChoices)
        
        let companyTextChoices = [
            ORKTextChoice(text: "Alone", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Spouse/Partner", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Children (your own or others')", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Friends", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Acquaintances", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Co-Workers", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Boss", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let companyTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: companyTextChoices)
        
        let environmentTextChoices = [
            ORKTextChoice(text: "Indoors", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Outdoors", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Both", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let environmentTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: environmentTextChoices)
        
        let temperatureTextChoices = [
            ORKTextChoice(text: "Too hot", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Just fine", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Too cold", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let temperatureTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: temperatureTextChoices)
        
        let stressTextChoices = [
            ORKTextChoice(text: "None", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Work-related", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Partner-related", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Children-related", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Friend-related", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Finance-related", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Health-related", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let stressTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: stressTextChoices)
        
        let moodTextChoices = [
            ORKTextChoice(text: "Poor", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Fair", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Good", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Very good", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Excellent", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let moodTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: moodTextChoices)
                        
        let experienceFormItem = ORKFormItem(identifier: "ExperienceFormItem1", text: "What were you doing during the last 2 hours? Remember: many of the activities could have happened over the 2-hour period.", answerFormat: activityTextChoiceAnswerFormat)
        let experienceFormItem2 = ORKFormItem(identifier: "ExperienceFormItem2", text: "Where were you during this 2-hour period? Remember: you may have been in more than one place over the 2-hour period.", answerFormat: locationTextChoiceAnswerFormat)
        let experienceFormItem3 = ORKFormItem(identifier: "ExperienceFormItem3", text: "Who were you with during this 2-hour period? Remember: you may have been with more than one person over the 2-hour period.", answerFormat: companyTextChoiceAnswerFormat)
        let experienceFormItem4 = ORKFormItem(identifier: "ExperienceFormItem4", text: "During this 2-hour period, did you spend the time indoor, outdoor, or both?", answerFormat: environmentTextChoiceAnswerFormat)
        let experienceFormItem5 = ORKFormItem(identifier: "ExperienceFormItem5", text: "During this 2-hour period, how was the temperature in your immediate surrounding?", answerFormat: temperatureTextChoiceAnswerFormat)
        let experienceFormItem6 = ORKFormItem(identifier: "ExperienceFormItem6", text: "Were there any stressful occurrences during the last 2 hours and, if so, please indicate the type of stressor?", answerFormat: stressTextChoiceAnswerFormat)
        let experienceFormItem7 = ORKFormItem(identifier: "ExperienceFormItem7", text: "How is your mood during the last 2 hours?", answerFormat: moodTextChoiceAnswerFormat)
        let experienceFormStep = ORKFormStep(identifier: "ExperienceFormStep", title: "Question #3", text: "Now, this set of questions is going to ask you about your experiences over the past 2 hours.")
        experienceFormStep.formItems = [experienceFormItem, experienceFormItem2, experienceFormItem3,experienceFormItem4, experienceFormItem5, experienceFormItem6, experienceFormItem7]
        steps += [experienceFormStep]
        
        // Q4: Pain?
        let painBooleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let painBooleanQuestionStep = ORKQuestionStep(identifier: "PainBooleanQuestionStep", title: nil, question: "Have you had any pain during this 2-hour period?", answer: painBooleanAnswer)
        steps += [painBooleanQuestionStep]
        
        // part 1 summary
        let partOneSummaryStep = ORKCompletionStep(identifier: "Part1SummaryStep")
        partOneSummaryStep.title = "Thank you for completing Daily Survey Part One."
        partOneSummaryStep.text = "We appreciate your time and you will be directed to complete Survey Part Two."
        steps += [partOneSummaryStep]
        
        // Pain Survey Boolean - specific time or constant
        let painDurationBooleanAnswer = ORKBooleanAnswerFormat(yesString: "Specific time(s)", noString: "Constant")
        let painDurationBooleanQuestionStep = ORKQuestionStep(identifier: "PainDurationStep", title: nil, question: "You've had pain during the last 2 hours. Did it occur during specific time(s) during the last 2 hours or was it constant during the last 2 hours?", answer: painDurationBooleanAnswer)
        steps += [painDurationBooleanQuestionStep]
        
        // Pain Survey 1
        // B1 instruction step
        let b1InstructionStep = ORKInstructionStep(identifier: "B1IntroStep")
        b1InstructionStep.title = "Pain Survey – Specific Times"
        b1InstructionStep.text = "The following survey will ask you more about your pain experience specifically during specific time(s) over the last 2 hours."
        steps += [b1InstructionStep]
        
        // Q1: FRQ for specific time pain (duration + intensity)
        let specificFRQAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        specificFRQAnswerFormat.multipleLines = false
        
        let specificFormItem1 = ORKFormItem(identifier: "SpecificFormItem1", text: "How long did it last (minutes)?", answerFormat: specificFRQAnswerFormat)
        let specificFormItem2 = ORKFormItem(identifier: "SpecificFormItem2", text: "How was the overall intensity of your pain during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense).", answerFormat: specificFRQAnswerFormat)
        let specificFormItem3 = ORKFormItem(identifier: "SpecificFormItem3", text: "How intense was your pain at its worst during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: specificFRQAnswerFormat)
        let specificFormItem4 = ORKFormItem(identifier: "SpecificFormItem4", text: "How intense was your pain at its mildest during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: specificFRQAnswerFormat)
        let specificFormStep = ORKFormStep(identifier: "SpecificFormStep", title: "Pain Questionnaire – Specific Times", text: "The following are a set of questions regarding the duration and intensity of your pain during specific time(s) over the last 2 hours.")
        specificFormStep.formItems = [specificFormItem1, specificFormItem2, specificFormItem3,specificFormItem4]
        specificFormStep.useCardView = false
        steps += [specificFormStep]
        
        // jump to pain questionnaire here
        
        // Pain Survey 2 - constant time
        // B2 instruction step
        let b2InstructionStep = ORKInstructionStep(identifier: "B2IntroStep")
        b2InstructionStep.title = "Pain Survey – Constant Time"
        b2InstructionStep.text = "The following survey will ask you more about your pain experience over a constant time."
        steps += [b2InstructionStep]
        
        // B2Q1: FRQ for constant time pain (duration + intensity)
        let constantPainBooleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        
        let constantFRQAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
        constantFRQAnswerFormat.multipleLines = false
        
        let constantTextChoices = [
            ORKTextChoice(text: "Constant throughout the 2-hour period.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "High early in the 2-hour period.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "High late in the 2-hour period.", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Very variable throughout the 2-hour period.", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let constantTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: constantTextChoices)
        
        let constantFormItem1 = ORKFormItem(identifier: "ConstantFormItem1", text: "You mentioned that you have experienced constant pain during the last 2 hours. Are you in pain right now?", answerFormat: constantPainBooleanAnswer)
        let constantFormItem2 = ORKFormItem(identifier: "ConstantFormItem2", text: "Please give me a number to describe the intensity of your pain during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: constantFRQAnswerFormat)
        let constantFormItem3 = ORKFormItem(identifier: "ConstantFormItem3", text: "What was the pattern of the pain over the last 2 hours?", answerFormat: constantTextChoiceAnswerFormat)
        let constantFormItem4 = ORKFormItem(identifier: "ConstantFormItem4", text: "How intense was your pain at its mildest during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: constantFRQAnswerFormat)
        let constantFormItem5 = ORKFormItem(identifier: "ConstantFormItem5", text: "How intense was your pain at its worse during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: constantFRQAnswerFormat)
        let constantFormStep = ORKFormStep(identifier: "ConstantFormStep", title: "Pain Questionnaire – Constant Time", text: "The following are a set of questions regarding the duration and intensity of your pain during the entirety over the last 2 hours.")
        constantFormStep.formItems = [constantFormItem1, constantFormItem2, constantFormItem3, constantFormItem4, constantFormItem5]
        constantFormStep.useCardView = false
        steps += [constantFormStep]
        
        // Pain Questionnaire
        // Q2: Pain location - multiple choice
        let b1Q2TextChoices = [
            ORKTextChoice(text: "Entire body", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Head", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Jaw", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Upper back", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Lower back", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Arms", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hands", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Legs", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Feet", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Chest/Upper body", value: 9 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Stomach/Abdomen/Lower body", value: 10 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Pelvic area", value: 11 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Joints", value: 12 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1Q2TextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1Q2TextChoices)
        let b1Q2TextStep = ORKQuestionStep(identifier: "B1Q2TextStep", title: "Pain Location", question: "Where in your body was the pain located?", answer: b1Q2TextChoiceAnswerFormat)
        steps += [b1Q2TextStep]
    
        // Q3: Pain sensation - multiple choice
        let b1Q3TextChoices = [
            ORKTextChoice(text: "Tingling", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Stabbing", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Sharp", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Dull", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Pinching", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hot", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Shooting", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1Q3TextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1Q3TextChoices)
        let b1Q3TextStep = ORKQuestionStep(identifier: "B1Q3TextStep", title: "Pain Sensation", question: "Please describe the sensation of the pain during the last 2 hours. Please include all body locations of pain.", answer: b1Q3TextChoiceAnswerFormat)
        steps += [b1Q3TextStep]
        
        // Q4: Can others tell - multiple choice
        let b1Q4TextChoices = [
            ORKTextChoice(text: "Yes: I was crying.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I was grimacing.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I was using an assistive device(s).", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I was limiting my movement/activities.", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes, I was rubbing/bracing the painful area in my body.", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Other.", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1Q4TextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1Q4TextChoices)
        let b1Q4TextStep = ORKQuestionStep(identifier: "B1Q4TextStep", title: "External Observation", question: "Could someone else see that you were in pain? That is, without you telling them.", answer: b1Q4TextChoiceAnswerFormat)
        steps += [b1Q4TextStep]
        
        // Q5: Pain impact - multiple choice
        let b1Q5TextChoices = [
            ORKTextChoice(text: "No.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I couldn't work.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I couldn't exercise.", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I couldn't care for children.", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: It made me go to bed.", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: It made me grumpy.", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I couldn't concentrate.", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I couldn't do housework.", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I could not relax.", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Other.", value: 9 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1Q5TextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1Q5TextChoices)
        let b1Q5TextStep = ORKQuestionStep(identifier: "B1Q5TextStep", title: "Physical Impact of Pain", question: "Did the pain that you felt during the last 2 hours impact what you were doing or what you wanted to do?", answer: b1Q5TextChoiceAnswerFormat)
        steps += [b1Q5TextStep]
        
        // Q6: Pain impact thought - multiple choice
        let b1Q6TextChoices = [
            ORKTextChoice(text: "No.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I could not think clearly.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I felt anxious about the pain.", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I worried that the pain might get worse.", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I could not stop thinking about the pain.", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I felt angry about the pain.", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I felt helpless.", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: I felt depressed because of the pain.", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Other.", value: 8 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1Q6TextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1Q6TextChoices)
        let b1Q6TextStep = ORKQuestionStep(identifier: "B1Q6TextStep", title: "Mental Impact of Pain", question: "Did the episode(s) of pain affect how you were thinking or feeling?", answer: b1Q6TextChoiceAnswerFormat)
        steps += [b1Q6TextStep]
        
        // Q7: Additional questions - FRQ form (suffering, palliation, and history)
        
        let b1PalliationTextChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Nonprescription Medicine", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Prescription Medicine", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Distraction", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Physical activity", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Meditation/Relaxation", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: Other", value: 6 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1PalliationTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: b1PalliationTextChoices)
        
        let b1HistoryTextChoices = [
            ORKTextChoice(text: "Yes: It was my typical pain.", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No: It was milder than my typical pain.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No: It was worse than my typical pain.", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let b1HistoryTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: b1HistoryTextChoices)
        
        let painFormItem1 = ORKFormItem(identifier: "PainFormItem1", text: "How much suffering did you experience because of your pain during the last 2 hours on a scale of 0 to 10 (0 means not at all intense and 10 means extremely intense)?", answerFormat: specificFRQAnswerFormat)
        let painFormItem2 = ORKFormItem(identifier: "PainFormItem2", text: "On a scale of 0 to 10, how important was it to you that you got relief from this episode of pain (0 means not at all important and 10 means couldn't be more important)?", answerFormat: specificFRQAnswerFormat)
        let painFormItem3 = ORKFormItem(identifier: "PainFormItem3", text: "Did you do anything to help relieve the pain that you felt during the last 2 hours?", answerFormat: b1PalliationTextChoiceAnswerFormat)
        let painFormItem4 = ORKFormItem(identifier: "PainFormItem4", text: "Was the pain you experienced during the last 2 hours typical of your usual pain?", answerFormat: b1HistoryTextChoiceAnswerFormat)
        let painFormStep = ORKFormStep(identifier: "PainFormStep", title: "Additional Questions Regarding Pain", text: "The following are a set of questions regarding the level of suffering, palliation, history, and other additional information of your pain during the last 2 hours.")
        painFormStep.formItems = [painFormItem1, painFormItem2, painFormItem3, painFormItem4]
        steps += [painFormStep]
        
        // final summary step
        let finalSummaryStep = ORKCompletionStep(identifier: "FinalSummaryStep")
        finalSummaryStep.title = "Thank you for completing all your daily surveys."
        finalSummaryStep.text = "We appreciate your time for completing all necessary daily surveys. Hope you're having a great day!"
        steps += [finalSummaryStep]
        
        // ORK predicate step
        // jump to pain boolean or end of survey
        let task = ORKNavigableOrderedTask(identifier: "task", steps: steps)
        let predicate1 = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "PainBooleanQuestionStep"), expectedAnswer: false)
        let rule1 = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate1, "FinalSummaryStep")])
        task.setNavigationRule(rule1, forTriggerStepIdentifier: "PainBooleanQuestionStep")
        
        // jump to specific time or constant pain
        let predicate2 = ORKResultPredicate.predicateForBooleanQuestionResult(with: ORKResultSelector(resultIdentifier: "PainDurationStep"), expectedAnswer: false)
        let rule2 = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate2, "B2IntroStep")])
        task.setNavigationRule(rule2, forTriggerStepIdentifier: "PainDurationStep")
        
        // jump to pain questionnaire after specific questions
        let rule3 = ORKDirectStepNavigationRule(destinationStepIdentifier: "B1Q2TextStep")
        task.setNavigationRule(rule3, forTriggerStepIdentifier: "SpecificFormStep")
        
        return task
        } ()
}
