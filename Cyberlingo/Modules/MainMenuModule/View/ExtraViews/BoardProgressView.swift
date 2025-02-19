//
//  BoardProgressView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import Foundation
import UIKit

class BoardProgressView: UIView {
    let height: CGFloat = 0.21
    let descruprionHeight: CGFloat = 0.25
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 20)
    let descriptionFont = UIFont.init(name: "Arial Light", size: 14)
    
    lazy var progressViewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
//        view.applyBlurEffect()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var progressLabel: UILabel = {
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
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.3)
        progressView.layer.cornerRadius = 5
        progressView.setProgress(0.8, animated: true)
        progressView.clipsToBounds = true
        return progressView
    }()

    init(progressText: String, progress: Float) {
        super.init(frame: .zero)
        progressLabel.text = progressText
        progressView.progress = progress
        setupView()
    }
    
    func update(progress: Int, progressCount: Int) {
        progressLabel.text = "\(progress) / \(progressCount)"
        progressView.progress = Float(progress) / Float(progressCount)
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
extension BoardProgressView {
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressViewBackground)
        
        NSLayoutConstraint.activate([
            progressViewBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            progressViewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            progressViewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            progressViewBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
        
        progressViewBackground.addSubviews(views: [
            progressLabel,
            progressView,
        ])
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: progressViewBackground.topAnchor, constant: 0),
            progressLabel.leadingAnchor.constraint(equalTo: progressViewBackground.leadingAnchor, constant: 10),
            progressLabel.bottomAnchor.constraint(equalTo: progressViewBackground.bottomAnchor, constant: 0),
            progressLabel.widthAnchor.constraint(greaterThanOrEqualTo: progressViewBackground.widthAnchor, multiplier: 0.12),

            progressView.centerYAnchor.constraint(equalTo: progressViewBackground.centerYAnchor, constant: 0),
            progressView.heightAnchor.constraint(equalTo: progressViewBackground.heightAnchor, multiplier: 0.25),
            progressView.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: progressViewBackground.trailingAnchor, constant: -10),
        ])
        
    }
    
}

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
