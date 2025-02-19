//
//  FinishModuleView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class FinishModuleView: UIView {
    
    private let viewBackgorund: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalisationManager.finishModuleTitle
        label.numberOfLines = 2
        label.font = FontLib.fontWithSize(font: .unboundedSemiBold, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉"
        label.font = .systemFont(ofSize: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.transform = CGAffineTransform(scaleX: -1, y: 1)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LocalisationManager.finishModuleDescription
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalisationManager.close, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
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
extension FinishModuleView {
    private func setupView() {
        backgroundColor = .clear
        clipsToBounds = false
        
        addSubview(viewBackgorund)

        viewBackgorund.addSubviews(views: [
            titleLabel,
            emojiLabel,
            descriptionLabel,
            actionButton
        ])
        
        NSLayoutConstraint.activate([
            viewBackgorund.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            viewBackgorund.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            viewBackgorund.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            viewBackgorund.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: viewBackgorund.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emojiLabel.leadingAnchor, constant: 30),
            titleLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
            
            emojiLabel.topAnchor.constraint(equalTo: viewBackgorund.topAnchor, constant: -30),
            emojiLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            emojiLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            emojiLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            
            actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
        ])
    }
}
