//
//  SwipeQuizExamView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

class SwipeQuizExamView: UIView {
    let cardStack = SwipeCardStack()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "Arial Bold", size: 30)
        label.text = "2:00"
        label.textAlignment = .center
        label.numberOfLines = 1
//        label.textColor = .white
        return label
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        label.text = "top"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        label.text = "right"
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.numberOfLines = 15
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        label.text = "bot"
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        label.text = "left"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 15
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func updateView(name: String) {
//        nameLabel.text = name
    }
    
    func updateAnswers(top: String, right: String, bot: String, left: String) {
        topLabel.text = top
        rightLabel.text = right
        bottomLabel.text = bot
        leftLabel.text = left
    }
    
    func hideAnswers() {
        topLabel.isHidden = true
        bottomLabel.isHidden = true
        leftLabel.isHidden = true
        rightLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension SwipeQuizExamView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(views: [
//            nameLabel,
            timerLabel,
            cardStack,
            topLabel,
            rightLabel,
            bottomLabel,
            leftLabel,
        ])
                
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            timerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            timerLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
//            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            nameLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
//            timerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
//            timerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            timerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
//            timerLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            
            cardStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cardStack.centerYAnchor.constraint(equalTo: rightLabel.centerYAnchor),
            cardStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            cardStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            
            topLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 15),
            topLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            topLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            topLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            
            bottomLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            bottomLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bottomLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            bottomLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            
            rightLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            rightLabel.leadingAnchor.constraint(equalTo: cardStack.trailingAnchor),
            rightLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor),
            
            leftLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            leftLabel.trailingAnchor.constraint(equalTo: cardStack.leadingAnchor),
            leftLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor),
        ])
        
    }
}
