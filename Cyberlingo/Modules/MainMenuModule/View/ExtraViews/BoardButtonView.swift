//
//  BoardButtonView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import Foundation
import UIKit

class BoardButtonView: UIView {
    let height: CGFloat = 0.21
    let descruprionHeight: CGFloat = 0.25
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 20)
    let descriptionFont = UIFont.init(name: "Arial Light", size: 14)
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.text = "Играть"
        label.textColor = .white
        return label
    }()
    
    init(buttonText: String) {
        super.init(frame: .zero)
        buttonLabel.text = buttonText
        setupView()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension BoardButtonView {
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            buttonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            buttonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
        
        buttonView.addSubviews(views: [
            buttonLabel,
        ])
        
        NSLayoutConstraint.activate([
            buttonLabel.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 0),
            buttonLabel.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 10),
            buttonLabel.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -10),
            buttonLabel.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 0),
        ])
        
    }
    
}
