//
//  CardCellDelegate.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


import Foundation
import UIKit

protocol CardCellDelegate {
    func soundTappd(cell: SwipeCard)
}

class CardView: SwipeCard {
    var cardCellDelegate: CardCellDelegate?
    var isFlipped: Bool?
    var lessonType: LessonType = .swipeQuizImage
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        view.layer.shadowRadius = 4.0
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var soundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("▶", for: .normal)
        button.layer.cornerRadius = 16
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(soundPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Карточка"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "Arial Bold", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var transcriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "Arial", size: 18)
        label.numberOfLines = 1
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    init(name: String, imageName: String, transcription: String?, type: LessonType) {
        super.init(frame: .zero)
        textLabel.text = name
        imageView.image = UIImage(named: imageName)
        lessonType = type
        switch type {
        case .swipeQuizImage, .phishingSwipeQuiz:
            textLabel.isHidden = true
            soundButton.isHidden = true
        case .swipeQuizAudio:
            textLabel.isHidden = true
            transcriptionLabel.text = transcription
            imageView.isHidden = true
        case .swipeQuizText:
            soundButton.isHidden = true
            imageView.isHidden = true
        default:
            print("CardView: SwipeCard: default type lesson")
        }
        setupView()
    }
    
    init(name: String, imageName: String, transcription: String?) {
        super.init(frame: .zero)
        textLabel.text = name
        imageView.image = imageName.textToImage()
        if transcription != nil && transcription != "" {
            transcriptionLabel.text = "[\(transcription!)]"
            transcriptionLabel.isHidden = false
        } else {
            transcriptionLabel.isHidden = true
        }
        setupView()
    }
    
    init(name: String, transcription: String?) {
        super.init(frame: .zero)
        textLabel.text = name
        imageView.isHidden = true
        soundButton.isHidden = true
        transcriptionLabel.isHidden = true
        setupView()
    }
    
    func update(word: String, translation: String) {
        textLabel.text = word
    }
    
    func flip(word: String, translation: String) {
        if lessonType == .phishingSwipeQuiz {
            if isFlipped != true {
                textLabel.text = translation
                textLabel.isHidden = false
                imageView.isHidden = true
                isFlipped = true
            } else {
                textLabel.isHidden = true
                imageView.isHidden = false
                isFlipped = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension CardView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubview(cardView)
        
        switch lessonType {
        case .swipeQuizAudio:
            cardView.addSubviews(views: [
//                imageView,
                soundButton,
                textLabel,
                transcriptionLabel,
            ])
            NSLayoutConstraint.activate([
                cardView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                cardView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1),
                cardView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
                
                soundButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                soundButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
                soundButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
                soundButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),

                textLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                textLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5),
                textLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),
                
                transcriptionLabel.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 15),
                transcriptionLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            ])
        default:
            cardView.addSubviews(views: [
                imageView,
                textLabel,
            ])
            NSLayoutConstraint.activate([
                cardView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                cardView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1),
                cardView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
                
                imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                
                textLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                textLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
                textLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
                
            ])
        }
        
    }
    
    @objc private func soundPressed() {
        cardCellDelegate?.soundTappd(cell: self)
    }

}
