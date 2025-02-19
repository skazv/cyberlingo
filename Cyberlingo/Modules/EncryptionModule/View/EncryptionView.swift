//
//  EncryptionView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 06.02.25.
//

import UIKit

class EncryptionView: UIView {
    var stackView = UIStackView()
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Расшифруйте текст"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .darkGray
        return label
    }()

    let alphabetLabel: UILabel = {
        let label = UILabel()
        label.text = "ABCDEFG"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .darkGray
        return label
    }()

    
    let rotLabel: UILabel = {
            let label = UILabel()
            label.text = "ROT13"
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textAlignment = .center
            label.textColor = .systemBlue
            return label
        }()
        
        let encryptedLabel: UILabel = {
            let label = UILabel()
            label.text = "Гзццб"
            label.font = .boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .darkGray
            return label
        }()
        
        let inputTextView: UITextView = {
            let textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 18)
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.layer.cornerRadius = 12
            textView.textAlignment = .left
            textView.textColor = .label
            textView.backgroundColor = .systemBackground
            return textView
        }()
        
        let checkButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(LocalisationManager.check, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF")
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            return button
        }()
        
        let resultLabel: UILabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.textColor = .black
            return label
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
extension EncryptionView {
    private func setupView() {
        backgroundColor = .systemBackground
        encryptedLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.translatesAutoresizingMaskIntoConstraints = false

        cardView.addSubviews(views: [
            encryptedLabel,
            inputTextView,
        ])
        resultLabel.isHidden = true
        stackView = UIStackView(arrangedSubviews: [subjectLabel, alphabetLabel, rotLabel, cardView, checkButton, resultLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(views: [
            stackView,
        ])
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            encryptedLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            encryptedLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            encryptedLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            inputTextView.topAnchor.constraint(equalTo: encryptedLabel.bottomAnchor, constant: 15),
            inputTextView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            inputTextView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            inputTextView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            inputTextView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            checkButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),
            
        ])
        
    }
}
