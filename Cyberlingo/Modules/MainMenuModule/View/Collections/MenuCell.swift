//
//  MenuCell.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//


import UIKit

class MenuCell: UICollectionViewCell {
    var constant1: NSLayoutConstraint?
    
    private lazy var lockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.isHidden = true
        return view
    }()
    
    private lazy var lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IconLib.lockFill.image.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    lazy var lockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Bold", size: 22)//.systemFont(ofSize: 12)//FontLib.fontWithSize(font: .aksharMedium, size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.text = "Выучи алфавит"
        label.textColor = .white
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 24)//UIFont(name: "Arial Bold", size: 22)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        //UIFont(name: "Arial Black", size: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white.withAlphaComponent(0.8)
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Arial Black", size: 20)
        label.textColor = .white
        label.text = "127 / 350"
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.3)
        progressView.layer.cornerRadius = 8
//        progressView.progress = 0.3
        progressView.setProgress(0.8, animated: true)
        return progressView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        //imageView.contentMode = .scaleAspectFit
        imageView.layer.opacity = 0.8
        return imageView
    }()
    
    func update(name: String, description: String, color: UIColor, imageName: UIImage, blendMode: String, isBlocked: Bool, count: Int, progress: Int?, progressCount: Int?) {
        nameLabel.text = name
        descriptionLabel.text = description
        contentView.backgroundColor = color
        let resizedImage = resizeImage(image: imageName, targetSize: CGSize(width: 300, height: 300))
        imageView.image = resizedImage//.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.alpha = 1.0
//        fill.blendMode(.plusDarker)
//        imageView.image?.draw(in: CGRect(origin: imageView.frame.origin, size: imageView.frame.size), blendMode: .plusDarker, alpha: 0.5)
        imageView.layer.compositingFilter = blendMode
        if blendMode == "screenBlendMode" {
            imageView.alpha = 0.6
        }
        if let progress ,let progressCount {
            progressLabel.text = "\(progress) / \(progressCount)"
            progressView.progress = Float(progress) / Float(progressCount)
        }
        if isBlocked {
            self.isBlocked()
        }
    }
    
    func isBlocked() {
        lockView.isHidden = false
        nameLabel.alpha = 0.7
        progressView.isHidden = true
        progressLabel.isHidden = true
        constant1?.isActive = false
        constant1 = nameLabel.topAnchor.constraint(equalTo: lockView.bottomAnchor, constant: 5)
        constant1?.isActive = true
    }
    
    func isBlockedRevers() {
        lockView.isHidden = true
        nameLabel.alpha = 1.0
        progressView.isHidden = false
        progressLabel.isHidden = false
        constant1?.isActive = false
        constant1 = nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15)
        constant1?.isActive = true
    }
    
    func isGame() {
        progressLabel.text = "Начать  〉"
        progressView.isHidden = true
    }
    
    init() {
        super.init(frame: .zero)
        setupCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func prepareForReuse() {
            super.prepareForReuse()
            progressView.isHidden = false
            lockView.isHidden = true
            isBlockedRevers()
//            contentView.backgroundColor = .systemBackground
//            countLabel.font = .boldSystemFont(ofSize: 18)
//            imageView.isHidden = true
//            alpha = 0
        }
    
}

//MARK: - Private methods
extension MenuCell {
    private func setupCell() {
        contentView.backgroundColor = .red//UIColor(named: ColorLib.iBubenSecondaryBackground.rawValue)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        
        contentView.addSubviews(views: [
            nameLabel,
            descriptionLabel,
            progressLabel,
            progressView,
            imageView,
            lockView,
        ])
        setupLockView()
        
        NSLayoutConstraint.activate([
            
            lockView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            lockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lockView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            lockView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),
            descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            
            progressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            progressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            progressLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
                        
            progressView.centerYAnchor.constraint(equalTo: progressLabel.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 5),
//            progressView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
            progressView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: -10),
            progressView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.06),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0),
            
        ])
        
        constant1 = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        constant1?.isActive = true
    }
    
    func setupLockView() {
        lockView.addSubviews(views: [
            lockImageView,
            lockLabel
        ])
        
        NSLayoutConstraint.activate([
        lockImageView.centerYAnchor.constraint(equalTo: lockView.centerYAnchor, constant: 0),
        lockImageView.leadingAnchor.constraint(equalTo: lockView.leadingAnchor, constant: 10),
        lockImageView.heightAnchor.constraint(equalTo: lockView.heightAnchor, multiplier: 0.7),
        lockImageView.widthAnchor.constraint(equalTo: lockView.heightAnchor, multiplier: 0.7),

        lockLabel.topAnchor.constraint(equalTo: lockView.topAnchor, constant: 0),
        lockLabel.leadingAnchor.constraint(equalTo: lockImageView.trailingAnchor, constant: 5),
        lockLabel.trailingAnchor.constraint(equalTo: lockView.trailingAnchor, constant: -10),
        lockLabel.bottomAnchor.constraint(equalTo: lockView.bottomAnchor, constant: 0),
        ])
        
    }
    
}


