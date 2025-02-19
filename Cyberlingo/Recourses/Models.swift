//
//  Models.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

struct ProfileSettignsSection {
    let name: String
    var settingsCell: [ProfileSettignsCell]
}

struct ProfileSettignsCell {
    let icon: UIImage
    let name: String
    let withIndecator: Bool
    var isAvailabel: Bool
    var description: String
}

struct MenuViewModel {
    let id: Int
    let name: String
    let imageName: UIImage
    let blendMode: String
    var isBlocked: Bool
    let color: UIColor
    var description: String
    var progress: Int?
    var progressCount: Int?
}

struct CourseViewModel {
    let id: Int
    let name: String
    let imageName: String
    var isBlocked: Bool
    var isExamPassed: Bool
    let color: String
    var description: String
    var lessons: [LessonViewModel]
}

struct LessonViewModel {
    let id: Int
    let lessonType: LessonType
    let name: String
    let imageName: String
    let view1image: String?
    let view1name: String?
    let view1videoUrl: String?
    let view1description: String?
    var isBlocked: Bool
    var isExamPassed: Bool
    let color: String
    var description: String
    var contentLesson: [ContentLessonViewModel]
    var quizQuestions :[QuizQuestion]
}

enum LessonType {
    case encryption
    case ceaserEncryption
    case symmetricEncryption
    case quizQuestion
    case sqlInjection
    case xssInjection
    case phishingSwipeQuiz
    case password
    case swipeQuizImage
    case swipeQuizAudio
    case swipeQuizText
    case swipeQuiz
    case video
    case quiz
    case reading
    case coding
}

enum PasswordScreenType {
    case dictionaryAtack
    case bruteForceAtack
}

struct ContentLessonViewModel {
    let id: Int
    let name: String
    let translate: String
    let transcription: String
    let image: String
    let type: String
    let category: String
    let remember: Int
    let module: String
    let description: String
    let sound: String
    var isFlipped: Bool
}

struct WordsVM {
    let name: String
    let armName: String
    let transcription: String
    let image: UIImage
    var isFlipped: Bool
}

enum AddMode {
    case add
    case update
}

enum Language: String {
    case ru
    case en
}

enum Theme: String {
    case light
    case dark
}

struct CourseTopicViewModel {
    let id: Int
    let name: String
    let imageName: String
    var isBlocked: Bool
    var isExamPassed: Bool
    let color: String
    var description: String
    var lessons: [LessonViewModel]
}

struct UserCardViewModel {
    var id: Int
    var word: String
    var translition: String
    var transcription: String?
    var memoryRate: Int
}

struct ExamViewModel {
    var name: String
    var isPassed: Bool
    var grade: Int
    var questions: Int
    var description: String
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswers: Set<String>
}

class QuizModel {
    var questions: [QuizQuestion] = [
        QuizQuestion(
            question: "Какое из следующих утверждений наилучшим образом описывает принцип 'наименьших привилегий'?",
            options: [
                "Любой пользователь должен иметь полный доступ к системе",
                "Доступ предоставляется только на основе временных ролей",
                "Пользователь или процесс должен иметь только минимально необходимый доступ",
                "Полный доступ предоставляется только администраторам"
            ],
            correctAnswers: ["Пользователь или процесс должен иметь только минимально необходимый доступ"]
        ),
        QuizQuestion(
            question: "Что означает конфиденциальность (Confidentiality) в триаде CIA?",
            options: [
                "Доступ к данным разрешён только авторизованным пользователям",
                "Данные остаются неизменными в процессе передачи",
                "Доступ к данным можно получить только в рабочие часы",
                "Данные зашифрованы во время хранения"
            ],
            correctAnswers: ["Доступ к данным разрешён только авторизованным пользователям"]
        )
        // Добавь остальные вопросы сюда
    ]
    
    var currentIndex = 0
    var score = 0
    
    func getCurrentQuestion() -> QuizQuestion {
        return questions[currentIndex]
    }
    
    func checkAnswers(_ selectedAnswers: Set<String>) -> Bool {
        let correct = selectedAnswers == questions[currentIndex].correctAnswers
        if correct { score += 1 }
        return correct
    }
    
    func nextQuestion() -> Bool {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            return true
        }
        return false
    }
    
    func getScore() -> Int {
        return score
    }
}
