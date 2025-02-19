//
//  UserCourseCell.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 03.02.25.
//


import UIKit

class UserCourseCell: UICollectionViewCell {
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 18)
    let descriptionFont = UIFont.init(name: "Arial Light", size: 14)
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Arial Bold", size: 16)
        label.textColor = .white
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
    
    func update(name: String, descriptions: String, color: UIColor, imageName: String, isBlocked: Bool, count: Int) {
        nameLabel.text = name
        imageView.image = UIImage(named: imageName)
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
    
}

//MARK: - Private methods
extension UserCourseCell {
    private func setupCell() {
        contentView.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF").withAlphaComponent(0.9)
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor().hexStringToUIColor(hex: "466CFF").cgColor
        contentView.addSubviews(views: [
            nameLabel,
            imageView,
        ])
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                        
        ])
        
    }
    
}


