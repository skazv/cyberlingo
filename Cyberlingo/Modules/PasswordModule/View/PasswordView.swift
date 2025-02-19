//
//  PasswordView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 13.02.25.
//

import UIKit

class PasswordView: UIView {
    var isStopped = false
    
    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Brute Force Exercise"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
        
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemGray6
        tf.placeholder = "Enter password..."
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        return tf
    }()
    
    let consoleView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .black
        textView.textColor = .green
        textView.isEditable = false
        textView.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        textView.layer.masksToBounds = true
        textView.layer.borderWidth = 2
//        textView.layer.cornerRadius = 20
        textView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        return textView
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Stop", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.opacity = 0.5
        button.layer.cornerRadius = 8
        button.isHidden = true
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension PasswordView {
    private func setupView() {
        backgroundColor = .systemBackground
        [titleLabel, infoLabel, passwordTextField, startButton, consoleView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            consoleView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            consoleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            consoleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            consoleView.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -16),

            passwordTextField.topAnchor.constraint(equalTo: consoleView.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -315),

            startButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            startButton.widthAnchor.constraint(equalToConstant: 120),
            startButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
}
