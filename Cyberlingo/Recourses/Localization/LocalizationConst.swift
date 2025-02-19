//
//  LocalizationConst.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import Foundation

struct LocalisationManager {
    static let trainingCourse = String(localized: "Training course")
    static let trainingCourseDescription = String(localized: "Learn the basics of cybersecurity")
    
    static let sertification = String(localized: "Certification")
    static let sertificationDescription = String(localized: "Take the exam and get a certificate")
    
    static let job = String(localized: "Job search")
    static let jobDescription = String(localized: "Start your career in cybersecurity")
    
    static let tools = String(localized: "Tools")
    static let toolsDescription = String(localized: "Useful tools for cybersecurity")
    
    //Course
    static let basicCourse = String(localized: "Basic Course")
    static let basicCourseDescription = String(localized: "Cybersecurity fundamentals")
    
    static let IntermediateCourse = String(localized: "Intermediate Course")
    static let IntermediateDescription = String(localized: "Hands-on vulnerability assessment")
    
    static let AdvancedCourse = String(localized: "Advanced Course")
    static let AdvancedCourseDescription = String(localized: "Exploitation and system defense")
    
    //Course By topics
    static let phishingCourse = String(localized: "Phishing")
    static let phishingCourseDescription = String(localized: "Cybersecurity fundamentals")
    
    static let cryptographyCourse = String(localized: "Cryptography")
    static let cryptographyCourseDescription = String(localized: "Hands-on vulnerability assessment")
    
    static let sqlInjectionCourse = String(localized: "SQL Injection")
    static let sqlInjectionCourseDescription = String(localized: "Cybersecurity fundamentals")
    
    static let passwordCourse = String(localized: "Password")
    static let passwordCourseDescription = String(localized: "Cybersecurity fundamentals")
    
    static let exam = String(localized: "Exam")
    
    static let courses: String = String(localized: "COURSES")
    static let customCourses: String = String(localized: "COURSES BY TOPIC")
    
    ///OnBoarding
    static let onBoardingHeader1: String = String(localized: "Let's learn CyberSecurity!")
    static let next: String = String(localized: "Next")
    static let letsGo: String = String(localized: "Let's go!")
    
    static let finishModuleTitle = String(localized: "Congratulations, you have completed the module!")
    static let finishModuleDescription = String(localized: "You have successfully finished the task! Keep up the great work!")
    static let close: String = String(localized: "Close")
    
    static let second = String(localized: "seconds")
    static let minutes = String(localized: "minutes")
    static let hours = String(localized: "hours")
    static let days = String(localized: "days")
    static let months = String(localized: "months")
    static let years = String(localized: "years")
    static let thousandYear = String(localized: "Thousand years")
    static let millionYears = String(localized: "Million years")
    static let billionYears = String(localized: "Billion years")
    static let selectImage = String(localized: "Select an image")
    
    static let learn = String(localized: "Learn")
    static let play = String(localized: "Play")
    static let read = String(localized: "Read")
    static let search = String(localized: "Search")
    static let check = String(localized: "Check")
    static let safe = String(localized: "Safe")
    static let notSafe = String(localized: "Not Safe")
    static let courseLockAlarm = String(localized: "Take the previous course first!")
    static let level: String = String(localized: "Level")
    static let message: String = String(localized: "Message")
    static let start: String = String(localized: "Start")
    static let decodetheText: String = String(localized: "Decode the text:")
    
    //Don't need!
    static let cardHint: String = String(localized: "Drag the card to the desired word.\nClick on the card for a hint")
    static let correctCard: String = String(localized: "Correct answer!\n\nCorrect:")
    static let wrongCard: String = String(localized: "Incorrect answer!\n\nCorrect:")
    static let correctAnser: String = String(localized: "Correct:")
    static let wrongAnser: String = String(localized: "Incorrect:")
    static let flipError: String = String(localized: "You cannot flip the card during the exam")
    
        
//SubscriobtionView
//    static let subscription: String = String(localized: "Subscription: ")
//    static let subscriptionActive: String = String(localized: "Active")
//    static let subscriptionNotActive: String = String(localized: "Not Active")
//    static let helpSubscription: String = String(localized: "Your subscription is a great help for the development of the project")
//    static let achievements: String = String(localized: "Achievements")
//    
//    ///SubscriobtionView and PayWall bot
//    static let restorePurchase: String = String(localized: "Restore Purchase")
//    static let termsOfUse: String = String(localized: "Terms of Use")
//    static let privacyPolicy: String = String(localized: "Privacy Policy")
//    
//    ///TabBar/NavBar
//    static let profile: String = String(localized: "Profile")
//    ///Alarms
//    static let letterLockAlarm = String(localized: "Unlock all the letters first!")
    
    
    
    //    ///Settings
//    static let main: String = String(localized: "Main")
//    static let language: String = String(localized: "Language")
//    static let darkTheme: String = String(localized: "Dark theme")
//    static let system: String = String(localized: "System")
//    static let dark: String = String(localized: "Dark")
//    static let light: String = String(localized: "Light")
//    static let saveProgress: String = String(localized: "Save progress")
//    static let gradeAppstore: String = String(localized: "Grade in Appstore")
//    static let share: String = String(localized: "Share")
//    static let contactUs: String = String(localized: "Contact us")
//    static let faq: String = String(localized: "FAQ")
    
    //    ///System
//    static let reset: String = String(localized: "Reset")
//    static let resetAllProgress: String = String(localized: "All progress will be reset. Are you sure?")
//    static let lockLetter: String = String(localized: "Letter not available!")
//    static let lockLetterMessage: String = String(localized: "Unlock the previous letter first")
//    static let unlockLetter: String = String(localized: "The letter is unlocked!")
//    static let unlockLetterMessage: String = String(localized: "Keep it up, you're doing great!")
//    static let inProgress: String = String(localized: "In progress")
//    static let changeLanguageWarning: String = String(localized: "To change the application language, go to your phone settings")
//    static let settings: String = String(localized: "Settings")
//    static let cancel: String = String(localized: "Cancel")
//    static let quizLetterLabel: String = String(localized: "What is the word in the picture?")
//    static let wrong: String = String(localized: "Wrong")
//    static let enterAnswer: String = String(localized: "Enter your answer")
//    static let translateProgress: String = String(localized: "The module has not yet been translated")
//    static let closeLetter: String = String(localized: "Close")
    
    ///Educaion
//    static let examStart: String = String(localized: "The exam will begin now!\nHints are disabled.\nYou will have 2 minutes.\nYou can’t make mistakes.\nAre you ready?:")
//    static let passExam: String = String(localized: "Congratulations!\n")//Поздравляем!\n \(examVM.grade) из \(examVM.questions). Следующий урок разблокирован!
//    static let passExam2: String = String(localized: "The next lesson is unlocked!")//Поздравляем!\n \(examVM.grade) из \(examVM.questions). Следующий урок разблокирован!
//    static let failExam: String = String(localized: "Unfortunately, your result is")//К сожалению, ваш результат \(examVM.grade) из \(examVM.questions). Попробуйте в следующий раз.
//    static let failExam2: String = String(localized: "Try it next time.")

//    static let allTopics: String = String(localized: "All topics")
//    static let shuffled: String = String(localized: "Shuffled")
//    static let byCategory: String = String(localized: "By category")
//    static let totalCards: String = String(localized: "Total cards")
//    static let remembered: String = String(localized: "Remembered")
//    static let percent: String = String(localized: "Percent")
}
