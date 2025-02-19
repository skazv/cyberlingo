//
//  TotalUserCardsView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


//import Foundation
//import UIKit
//
//class TotalUserCardsView: UIView {
//    lazy var totalView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemBackground
//        view.layer.cornerRadius = 15
//        return view
//    }()
//    
//    lazy var totalCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var rememberCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var percentCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var okButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("OK", for: .normal)
//        button.backgroundColor = .systemOrange
//        button.layer.cornerRadius = 20
//        return button
//    }()
//    
//    init() {
//        super.init(frame: .zero)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
////MARK: - Private methods
//extension TotalUserCardsView {
//    private func setupView() {
//        backgroundColor = .secondarySystemBackground
//        
//        addSubviews(views: [
//            totalView,
//        ])
//        
//        totalView.addSubviews(views: [
//            totalCountLabel,
//            rememberCountLabel,
//            percentCountLabel,
//            okButton,
//        ])
//        
//        NSLayoutConstraint.activate([
//            totalView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            totalView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            totalView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            totalView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//        ])
//        
//        NSLayoutConstraint.activate([
//            totalCountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
//            totalCountLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            totalCountLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
//            totalCountLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
//            
//            rememberCountLabel.topAnchor.constraint(equalTo: totalCountLabel.bottomAnchor, constant: 15),
//            rememberCountLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            rememberCountLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
//            rememberCountLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
//            
//            percentCountLabel.topAnchor.constraint(equalTo: rememberCountLabel.bottomAnchor, constant: 15),
//            percentCountLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
//            percentCountLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
//            percentCountLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
//            
//            okButton.topAnchor.constraint(equalTo: percentCountLabel.bottomAnchor, constant: 15),
//            okButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
//            okButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
//            okButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
//        ])
//        
//    }
//}
