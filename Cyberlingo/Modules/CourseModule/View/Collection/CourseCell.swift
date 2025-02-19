//
//  CourseCell.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//


import UIKit

class CourseCell: UICollectionViewCell {
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 18)
    let descriptionFont = UIFont.init(name: "Arial Light", size: 14)
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Arial Bold", size: 20)
        imageView.contentMode = .scaleAspectFit
        label.textColor = .white
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.trainingCourseDescription
        label.adjustsFontSizeToFitWidth = true
        label.font = descriptionFont
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.opacity = 0.8
        imageView.layer.compositingFilter = BlendLib.luminosityBlendMode.rawValue
        return imageView
    }()
    
    private lazy var imageLockView: UIImageView = {
        let image = UIImage(systemName: IconLib.lockFill.rawValue)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func update(name: String, descriptions: String, color: UIColor, imageName: String, isBlocked: Bool) {
        nameLabel.text = name
        contentView.backgroundColor = color
        descriptionLabel.text = descriptions
        imageView.image = UIImage(named: imageName)
        if isBlocked {
            imageLockView.isHidden = false
            nameLabel.alpha = 0.6
            descriptionLabel.alpha = 0.6
            imageView.alpha = 0.6
        } else {
            imageLockView.isHidden = true
        }
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
        nameLabel.alpha = 1
        descriptionLabel.alpha = 1
        imageView.alpha = 1
        imageLockView.isHidden = true
    }
    
}

//MARK: - Private methods
extension CourseCell {
    private func setupCell() {
        contentView.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF")
        contentView.layer.cornerRadius = 20
        
        
        contentView.addSubviews(views: [
            nameLabel,
            imageView,
            descriptionLabel,
            imageLockView,
        ])
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -2),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            
            imageLockView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageLockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageLockView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            imageLockView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
        ])
        
    }
    
}


