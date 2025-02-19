//
//  QuizQuestionViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class QuizQuestionViewController: UIViewController {
    let quizQuestionView = QuizQuestionView()
    var presenter: QuizQuestionPresenterProtocol?
    var lesson: LessonViewModel?
    private var questions: [QuizQuestion] = []
    private var currentQuestionIndex = 0
    private var selectedAnswers = Set<String>()
    private var score = 0
    
    override func loadView() {
        super.loadView()
        view = quizQuestionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadQuestions()
        showCurrentQuestion()
    }
    
}


//MARK: - Private methods
extension QuizQuestionViewController {
    private func setup() {
        quizQuestionView.onAnswerSelected = { [weak self] answer in
            self?.toggleAnswer(answer)
        }
        
        quizQuestionView.onSubmit = { [weak self] in
            self?.submitAnswer()
        }
    }
   
    private func loadQuestions() {
        questions = [
            QuizQuestion(
                question: "Which of the following principles relate to the concept of 'Defense in Depth'?",
                options: ["Multi-factor authentication", "Using antivirus software", "Role-based access control", "Network segmentation"],
                correctAnswers: ["Multi-factor authentication", "Network segmentation"]
            ),
            QuizQuestion(
                question: "What are common types of social engineering attacks?",
                options: ["Phishing", "Brute force attack", "Tailgating", "Denial-of-service (DoS) attack"],
                correctAnswers: ["Phishing", "Tailgating"]
            ),
            QuizQuestion(
                question: "Which authentication factors are considered strong when used together?",
                options: ["Password and PIN", "Fingerprint and password", "Security question and email verification", "Smart card and biometric scan"],
                correctAnswers: ["Fingerprint and password", "Smart card and biometric scan"]
            ),
            QuizQuestion(
                question: "What are key principles of least privilege?",
                options: ["Users should only have access necessary for their job", "All users should have admin access", "Permissions should be granted temporarily when needed", "Access should be unrestricted"],
                correctAnswers: ["Users should only have access necessary for their job", "Permissions should be granted temporarily when needed"]
            ),
            QuizQuestion(
                question: "Which are common ways to mitigate insider threats?",
                options: ["Implementing least privilege", "Conducting regular security awareness training", "Allowing unrestricted access to internal systems", "Using strong passwords"],
                correctAnswers: ["Implementing least privilege", "Conducting regular security awareness training"]
            ),
            QuizQuestion(
                question: "Which types of encryption methods are commonly used to protect data at rest?",
                options: ["AES", "RSA", "SHA-256", "Blowfish"],
                correctAnswers: ["AES", "Blowfish"]
            ),
            QuizQuestion(
                question: "Which security controls help prevent unauthorized physical access?",
                options: ["Security cameras", "Biometric access control", "Data encryption", "Firewalls"],
                correctAnswers: ["Security cameras", "Biometric access control"]
            ),
            QuizQuestion(
                question: "Which actions are considered good cybersecurity hygiene?",
                options: ["Regularly updating software", "Using the same password for all accounts", "Enabling multi-factor authentication", "Sharing passwords securely via email"],
                correctAnswers: ["Regularly updating software", "Enabling multi-factor authentication"]
            ),
            QuizQuestion(
                question: "What are common indicators of a phishing attack?",
                options: ["Urgent language requesting immediate action", "Suspicious email addresses or domains", "Attachments with unusual file extensions", "Messages with perfect grammar and spelling"],
                correctAnswers: ["Urgent language requesting immediate action", "Suspicious email addresses or domains", "Attachments with unusual file extensions"]
            ),
            QuizQuestion(
                question: "Which techniques can be used to detect anomalies in network traffic?",
                options: ["Intrusion detection systems (IDS)", "Penetration testing", "Behavioral analysis", "Firewall rule auditing"],
                correctAnswers: ["Intrusion detection systems (IDS)", "Behavioral analysis"]
            )
        ]
        questions.shuffle()
    }

    
    private func showCurrentQuestion() {
        guard currentQuestionIndex < questions.count else {
            finishQuiz()
            return
        }
        let question = questions[currentQuestionIndex]
        quizQuestionView.updateQuestion(question)
        selectedAnswers.removeAll()
    }
    
    private func submitAnswer() {
        guard currentQuestionIndex < questions.count else { return }
        
        let currentQuestion = questions[currentQuestionIndex]
        let isCorrect = selectedAnswers == currentQuestion.correctAnswers
        
        if isCorrect { score += 1 }
        
        currentQuestionIndex += 1
        showCurrentQuestion()
    }
    
    private func finishQuiz() {
        let alert = UIAlertController(title: "Квиз завершён", message: "Ваш счёт: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default) { _ in
            self.currentQuestionIndex = 0
            self.score = 0
            self.showCurrentQuestion()
        })
        present(alert, animated: true)
    }
    
    private func toggleAnswer(_ answer: String) {
        if selectedAnswers.contains(answer) {
            selectedAnswers.remove(answer)
        } else {
            selectedAnswers.insert(answer)
        }
    }

}


//MARK: - QuizQuestionViewProtocol
extension QuizQuestionViewController: QuizQuestionViewProtocol {
}
