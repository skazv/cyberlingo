//
//  SwipeQuizView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

class SwipeQuizView: UIView {
    let cardStack = SwipeCardStack()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "Lorem ipsumorem ipsumorem ipsumorem ipsumorem ipsumorem ipsumorem ipsumorem ipsumorem ipsum"
        return label
    }()
    
//    lazy var topLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.sizeToFit()
//        label.minimumScaleFactor = 0.5
//        label.text = "top"
//        label.textColor = .systemBlue
//        label.textAlignment = .center
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
    
//    lazy var rightLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.sizeToFit()
//        label.minimumScaleFactor = 0.5
//        label.text = "right"
//        label.textColor = .systemGreen
//        label.textAlignment = .center
//        label.numberOfLines = 15
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
    
//    lazy var bottomLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.sizeToFit()
//        label.minimumScaleFactor = 0.5
//        label.text = "bot"
//        label.textColor = .systemYellow
//        label.textAlignment = .center
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
    
//    lazy var leftLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.sizeToFit()
//        label.minimumScaleFactor = 0.5
//        label.text = "left"
//        label.textColor = .systemRed
//        label.textAlignment = .center
//        label.numberOfLines = 15
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalisationManager.next, for: .normal)
        button.layer.cornerRadius = 20
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemOrange
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalisationManager.next, for: .normal)
        button.layer.cornerRadius = 20
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemGreen
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func updateView(name: String) {
        nameLabel.text = name
    }
    
//    func updateAnswers(top: String, right: String, bot: String, left: String) {
//        topLabel.text = top
//        rightLabel.text = right
//        bottomLabel.text = bot
//        leftLabel.text = left
//    }
//    
//    func hideAnswers() {
//        topLabel.isHidden = true
//        bottomLabel.isHidden = true
//        leftLabel.isHidden = true
//        rightLabel.isHidden = true
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension SwipeQuizView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(views: [
            nameLabel,
            cardStack,
//            topLabel,
//            rightLabel,
//            bottomLabel,
            leftButton,
            rightButton,
//            leftLabel,
        ])
                
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            cardStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cardStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -50),
            cardStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.7),
            cardStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            
//            topLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
//            topLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
//            topLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
//            topLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            
//            bottomLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
//            bottomLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
//            bottomLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
//            bottomLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            
            leftButton.topAnchor.constraint(equalTo: cardStack.bottomAnchor, constant: 15),
            leftButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -80),
            leftButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.14),
            leftButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.35),
            
            rightButton.topAnchor.constraint(equalTo: cardStack.bottomAnchor, constant: 15),
            rightButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 80),
            rightButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.14),
            rightButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.35),
            
//            rightLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
//            rightLabel.leadingAnchor.constraint(equalTo: cardStack.trailingAnchor),
//            rightLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
//            rightLabel.bottomAnchor.constraint(equalTo: rightButton.topAnchor),
//            
//            leftLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
//            leftLabel.trailingAnchor.constraint(equalTo: cardStack.leadingAnchor),
//            leftLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
//            leftLabel.bottomAnchor.constraint(equalTo: rightButton.topAnchor),
        ])
        
    }
}
