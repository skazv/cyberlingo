//
//  QuizQuestionView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class QuizQuestionView: UIView {
    
    var onAnswerSelected: ((String) -> Void)?
    var onSubmit: (() -> Void)?
    
    private let questionLabel = UILabel()
    private var answerButtons: [UIButton] = []
    private let submitButton = UIButton(type: .system)
    
    private var selectedAnswerButtons = Set<UIButton>()  // Множественный выбор
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension QuizQuestionView {
    private func setupView() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .secondarySystemBackground
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionLabel)
        
        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStack)

        for _ in 0..<4 {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .systemBackground
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
            buttonStack.addArrangedSubview(button)
            answerButtons.append(button)
        }

        submitButton.setTitle(LocalisationManager.next, for: .normal)
        submitButton.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF")
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 20
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateQuestion(_ question: QuizQuestion) {
        questionLabel.text = question.question
        selectedAnswerButtons.removeAll() // Сбрасываем выбор при смене вопроса
        
        for (index, button) in answerButtons.enumerated() {
            if index < question.options.count {
                button.setTitle(question.options[index], for: .normal)
                button.isHidden = false
                resetButtonStyle(button) // Сбрасываем стиль
            } else {
                button.isHidden = true
            }
        }
    }
    
    @objc private func answerTapped(sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        
        if selectedAnswerButtons.contains(sender) {
            selectedAnswerButtons.remove(sender)
            resetButtonStyle(sender)
        } else {
            selectedAnswerButtons.insert(sender)
            sender.backgroundColor = .systemGreen
            sender.setTitleColor(.black, for: .normal)
        }
        
        onAnswerSelected?(answer)
    }
    
    @objc private func submitTapped() {
        onSubmit?()
    }
    
    private func resetButtonStyle(_ button: UIButton) {
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
    }
}


//import UIKit
//
//class QuizQuestionView: UIView {
//    
//    var onAnswerSelected: ((String) -> Void)?
//    var onSubmit: (() -> Void)?
//    
//    private let questionLabel = UILabel()
//    private var answerButtons: [UIButton] = []
//    private let submitButton = UIButton(type: .system)
//    
//    private var selectedAnswerButton: UIButton?  // Храним выбранную кнопку
//    
//    init() {
//        super.init(frame: .zero)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Private methods
//extension QuizQuestionView {
//    private func setupView() {
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//
//        backgroundColor = .secondarySystemBackground
//        questionLabel.textAlignment = .center
//        questionLabel.numberOfLines = 0
//        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        questionLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(questionLabel)
//        
//        let buttonStack = UIStackView()
//        buttonStack.axis = .vertical
//        buttonStack.spacing = 10
//        buttonStack.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(buttonStack)
//
//        for _ in 0..<4 {
//            let button = UIButton(type: .system)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.backgroundColor = .systemBlue
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            button.layer.cornerRadius = 10
//            button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
//            buttonStack.addArrangedSubview(button)
//            answerButtons.append(button)
//        }
//
//        submitButton.setTitle("Ответить", for: .normal)
//        submitButton.backgroundColor = .systemGreen
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.layer.cornerRadius = 10
//        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
//        addSubview(submitButton)
//        
//        NSLayoutConstraint.activate([
//            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
//            questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            
//            buttonStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
//            buttonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            buttonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            
//            submitButton.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
//            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            submitButton.widthAnchor.constraint(equalToConstant: 200),
//            submitButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    func updateQuestion(_ question: QuizQuestion) {
//        questionLabel.text = question.question
//        selectedAnswerButton = nil // Сбрасываем выбор при смене вопроса
//        
//        for (index, button) in answerButtons.enumerated() {
//            if index < question.options.count {
//                button.setTitle(question.options[index], for: .normal)
//                button.isHidden = false
//                resetButtonStyle(button) // Сбрасываем стиль
//            } else {
//                button.isHidden = true
//            }
//        }
//    }
//    
//    @objc private func answerTapped(sender: UIButton) {
//        guard let answer = sender.currentTitle else { return }
//        
//        // Сбрасываем стиль у предыдущей выбранной кнопки
//        if let previousButton = selectedAnswerButton {
//            resetButtonStyle(previousButton)
//        }
//        
//        // Обновляем выбранную кнопку
//        selectedAnswerButton = sender
//        sender.backgroundColor = .systemGreen
//        sender.setTitleColor(.black, for: .normal)
//        
//        onAnswerSelected?(answer)
//    }
//    
//    @objc private func submitTapped() {
//        onSubmit?()
//    }
//    
//    private func resetButtonStyle(_ button: UIButton) {
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//    }
//}



//import UIKit
//
//class QuizQuestionView: UIView {
//    
//    var onAnswerSelected: ((String) -> Void)?
//    var onSubmit: (() -> Void)?
//    
//    private let questionLabel = UILabel()
//    private var answerButtons: [UIButton] = []
//    private let submitButton = UIButton(type: .system)
//    
//    init() {
//        super.init(frame: .zero)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Private methods
//extension QuizQuestionView {
//    private func setupView() {
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//
//        backgroundColor = .secondarySystemBackground
//        questionLabel.textAlignment = .center
//        questionLabel.numberOfLines = 0
//        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        questionLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(questionLabel)
//        
//        let buttonStack = UIStackView()
//        buttonStack.axis = .vertical
//        buttonStack.spacing = 10
//        buttonStack.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(buttonStack)
//
//        for _ in 0..<4 {
//            let button = UIButton(type: .system)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.backgroundColor = .systemBlue
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//            button.layer.cornerRadius = 10
//            button.addTarget(self, action: #selector(answerTapped), for: .touchUpInside)
//            buttonStack.addArrangedSubview(button)
//            answerButtons.append(button)
//        }
//
//        
//        submitButton.setTitle("Ответить", for: .normal)
//        submitButton.backgroundColor = .systemGreen
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.layer.cornerRadius = 10
//        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
//        addSubview(submitButton)
//        
//        NSLayoutConstraint.activate([
//            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
//            questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            questionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            
//            buttonStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
//            buttonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            buttonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            
//            submitButton.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
//            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            submitButton.widthAnchor.constraint(equalToConstant: 200),
//            submitButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    func updateQuestion(_ question: QuizQuestion) {
//        questionLabel.text = question.question
//        for (index, button) in answerButtons.enumerated() {
//            if index < question.options.count {
//                button.setTitle(question.options[index], for: .normal)
//                button.isHidden = false
//            } else {
//                button.isHidden = true
//            }
//        }
//    }
//    
//    @objc private func answerTapped(sender: UIButton) {
//        guard let answer = sender.currentTitle else { return }
//        onAnswerSelected?(answer)
//    }
//    
//    @objc private func submitTapped() {
//        onSubmit?()
//    }
//}
