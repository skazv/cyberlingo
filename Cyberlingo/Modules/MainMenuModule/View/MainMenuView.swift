//
//  MainMenuView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//

import UIKit

class MainMenuView: UIView {
    
    let height: CGFloat = 0.21
    let descruprionHeight: CGFloat = 0.25
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 20)
    let descriptionFont = UIFont.init(name: "Arial Light", size: 14)
    let playView = BoardButtonView(buttonText: LocalisationManager.check)
    let readView = BoardButtonView(buttonText: LocalisationManager.search)
    let educitionLvlView = BoardButtonView(buttonText: "1 \(LocalisationManager.level)")
    let letterProgressView = BoardProgressView(progressText: "10/100", progress: 0.1)
    let wordProgressView = BoardProgressView(progressText: "", progress: 0)

    
    lazy var educationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF")
        view.layer.cornerRadius = 20
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var educationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.trainingCourse
        label.adjustsFontSizeToFitWidth = true
        label.font = headerFont
        label.scalesLargeContentImage = true
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var educationDescriptionLabel: UILabel = {
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
    
    lazy var educationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: ConstantNames.menu1)
        imageView.layer.compositingFilter = BlendLib.luminosityBlendMode.rawValue
        return imageView
    }()
    
    lazy var certificateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "339F3E")
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var certificateNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.sertification
        label.textColor = .white
        label.textAlignment = .left
        label.font = headerFont
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var certificateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.sertificationDescription
        label.textColor = .white
        label.textAlignment = .left
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var certificateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: ConstantNames.menu2)
        imageView.layer.compositingFilter = BlendLib.luminosityBlendMode.rawValue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var jobView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "E34A8B")
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var jobNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.job
        label.textColor = .white
        label.textAlignment = .left
        label.font = headerFont
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var jobDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.jobDescription
        label.textColor = .white
        label.textAlignment = .left
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var jobImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        let image = UIImage(named: ConstantNames.menu3) ?? .actions
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 500, height: 500))
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFit
        imageView.layer.compositingFilter = BlendLib.hardLightBlendMode.rawValue
        return imageView
    }()
    
    lazy var toolsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().hexStringToUIColor(hex: "9E4AE3")
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var toolsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.tools
        label.textColor = .white
        label.textAlignment = .left
        label.font = headerFont
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var toolsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalisationManager.toolsDescription
        label.textColor = .white
        label.textAlignment = .left
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var toolsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        let image = UIImage(named: ConstantNames.menu4) ?? .actions
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 500, height: 500))
        imageView.image = resizedImage
        imageView.contentMode = .scaleAspectFit
        imageView.layer.compositingFilter = BlendLib.luminosityBlendMode.rawValue
//        imageView.alpha = 0.9
        return imageView
    }()
    
    private lazy var lockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white.withAlphaComponent(0.2)
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
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var lockViewWord: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.isHidden = true
        return view
    }()
    
    private lazy var lockImageViewWord: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = IconLib.lockFill.image.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    lazy var lockLabelWord: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = descriptionFont
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var lockImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ConstantNames.lock2)
        return imageView
    }()
    
    private lazy var lockImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ConstantNames.lock3)
        return imageView
    }()
    
    func blockEducation() {
        lockView.isHidden = false
        certificateNameLabel.alpha = 0.5
        certificateImageView.alpha = 0.5
        certificateDescriptionLabel.alpha = 0.5
        educitionLvlView.isHidden = true
        lockImageView2.isHidden = true
        lockImageView3.isHidden = true
    }
    
    func unblockEducation() {
        lockView.isHidden = true
        certificateNameLabel.alpha = 1.0
        certificateImageView.alpha = 1.0
        certificateDescriptionLabel.alpha = 1.0
        educitionLvlView.isHidden = false
        lockImageView2.isHidden = false
        lockImageView3.isHidden = false
    }
    
    func blockWord() {
        wordProgressView.isHidden = true
        lockViewWord.isHidden = false
    }
    
    func unblockWord() {
        wordProgressView.isHidden = false
        lockViewWord.isHidden = true
    }
    
}

//MARK: - Private methods
extension MainMenuView {
    private func setupView() {
        backgroundColor = .systemBackground
        
        addSubviews(views: [
            educationView,
            certificateView,
            jobView,
            toolsView,
        ])
        
        alphabetViewSetup()
        educationViewSetup()
        storyViewSetup()
        toolsViewSetup()
        
        NSLayoutConstraint.activate([
            educationView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            educationView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            educationView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            educationView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: height),
            
            certificateView.topAnchor.constraint(equalTo: educationView.bottomAnchor, constant: 10),
            certificateView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            certificateView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            certificateView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: height),
            
            jobView.topAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: 10),
            jobView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            jobView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            jobView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: height),
            
            toolsView.topAnchor.constraint(equalTo: jobView.bottomAnchor, constant: 10),
            toolsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            toolsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            toolsView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: height),
        ])
        
    }
    
    func alphabetViewSetup() {
        educationView.addSubviews(views: [
            educationNameLabel,
            educationImageView,
            educationDescriptionLabel,
            letterProgressView,
        ])
        
        letterProgressView.progressViewBackground.backgroundColor = .white.withAlphaComponent(0.3)
        
        NSLayoutConstraint.activate([
            educationNameLabel.topAnchor.constraint(equalTo: educationView.topAnchor, constant: 15),
            educationNameLabel.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 15),
            educationNameLabel.trailingAnchor.constraint(equalTo: educationImageView.centerXAnchor),
            educationNameLabel.heightAnchor.constraint(equalTo: educationView.heightAnchor, multiplier: 0.2),
            
            educationDescriptionLabel.topAnchor.constraint(equalTo: educationNameLabel.bottomAnchor, constant: 5),
            educationDescriptionLabel.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 15),
            educationDescriptionLabel.trailingAnchor.constraint(equalTo: educationView.centerXAnchor),
            educationDescriptionLabel.heightAnchor.constraint(equalTo: educationView.heightAnchor, multiplier: descruprionHeight),
            
            educationImageView.trailingAnchor.constraint(equalTo: educationView.trailingAnchor, constant: 10),
            educationImageView.bottomAnchor.constraint(equalTo: educationView.bottomAnchor, constant: 0),
            educationImageView.heightAnchor.constraint(equalTo: educationView.heightAnchor, multiplier: 1.0),
            educationImageView.widthAnchor.constraint(equalTo: educationView.heightAnchor, multiplier: 1.0),
            
            letterProgressView.leadingAnchor.constraint(equalTo: educationView.leadingAnchor, constant: 15),
            letterProgressView.bottomAnchor.constraint(equalTo: educationView.bottomAnchor, constant: -15),
            letterProgressView.heightAnchor.constraint(equalTo: educationView.heightAnchor, multiplier: 0.22),
            letterProgressView.trailingAnchor.constraint(equalTo: educationView.trailingAnchor, constant: -15),
        ])
    }
    
    func educationViewSetup() {
        certificateView.addSubviews(views: [
            certificateNameLabel,
            certificateImageView,
            certificateDescriptionLabel,
            educitionLvlView,
            lockView,
            lockImageView2,
            lockImageView3,
        ])
        
        
        lockViewSetup()
        lockViewWordSetup()
        
        NSLayoutConstraint.activate([
            certificateNameLabel.topAnchor.constraint(equalTo: certificateView.topAnchor, constant: 15),
            certificateNameLabel.leadingAnchor.constraint(equalTo: certificateView.leadingAnchor, constant: 15),
            certificateNameLabel.trailingAnchor.constraint(equalTo: certificateImageView.centerXAnchor),
            certificateNameLabel.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.2),
            
            certificateDescriptionLabel.topAnchor.constraint(equalTo: certificateNameLabel.bottomAnchor, constant: 5),
            certificateDescriptionLabel.leadingAnchor.constraint(equalTo: certificateView.leadingAnchor, constant: 15),
            certificateDescriptionLabel.trailingAnchor.constraint(equalTo: certificateView.centerXAnchor, constant: 15),
            certificateDescriptionLabel.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: descruprionHeight),
            
            certificateImageView.trailingAnchor.constraint(equalTo: certificateView.trailingAnchor, constant: 20),
            certificateImageView.bottomAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: -5),
            certificateImageView.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 1.0),
            certificateImageView.widthAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 1.0),
            
            educitionLvlView.leadingAnchor.constraint(equalTo: certificateView.leadingAnchor, constant: 15),
            educitionLvlView.bottomAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: -15),
            educitionLvlView.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            educitionLvlView.widthAnchor.constraint(equalTo: certificateView.widthAnchor, multiplier: 0.24),
            
            lockImageView2.leadingAnchor.constraint(equalTo: educitionLvlView.trailingAnchor, constant: 8),
            lockImageView2.bottomAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: -15),
            lockImageView2.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            lockImageView2.widthAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            
            lockImageView3.leadingAnchor.constraint(equalTo: lockImageView2.trailingAnchor, constant: 8),
            lockImageView3.bottomAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: -15),
            lockImageView3.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            lockImageView3.widthAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            
            lockView.leadingAnchor.constraint(equalTo: certificateView.leadingAnchor, constant: 15),
            lockView.bottomAnchor.constraint(equalTo: certificateView.bottomAnchor, constant: -15),
            lockView.heightAnchor.constraint(equalTo: certificateView.heightAnchor, multiplier: 0.22),
            lockView.widthAnchor.constraint(equalTo: certificateView.widthAnchor, multiplier: 0.43),
        ])
    }
    
    func storyViewSetup() {
        jobView.addSubviews(views: [
            jobNameLabel,
            jobImageView,
            jobDescriptionLabel,
        ])
        
        jobView.addSubview(readView)
        
        NSLayoutConstraint.activate([
            jobNameLabel.topAnchor.constraint(equalTo: jobView.topAnchor, constant: 15),
            jobNameLabel.leadingAnchor.constraint(equalTo: jobView.leadingAnchor, constant: 15),
            jobNameLabel.trailingAnchor.constraint(equalTo: jobImageView.centerXAnchor),
            jobNameLabel.heightAnchor.constraint(equalTo: jobView.heightAnchor, multiplier: 0.2),
            
            jobDescriptionLabel.topAnchor.constraint(equalTo: jobNameLabel.bottomAnchor, constant: 5),
            jobDescriptionLabel.leadingAnchor.constraint(equalTo: jobView.leadingAnchor, constant: 15),
            jobDescriptionLabel.trailingAnchor.constraint(equalTo: jobView.centerXAnchor, constant: 15),
            jobDescriptionLabel.heightAnchor.constraint(equalTo: jobView.heightAnchor, multiplier: descruprionHeight),
            
            jobImageView.trailingAnchor.constraint(equalTo: jobView.trailingAnchor, constant: 10),
            jobImageView.bottomAnchor.constraint(equalTo: jobView.bottomAnchor, constant: 0),
            jobImageView.heightAnchor.constraint(equalTo: jobView.heightAnchor, multiplier: 1.0),
            jobImageView.widthAnchor.constraint(equalTo: jobView.heightAnchor, multiplier: 1.0),
            
            readView.leadingAnchor.constraint(equalTo: jobView.leadingAnchor, constant: 15),
            readView.bottomAnchor.constraint(equalTo: jobView.bottomAnchor, constant: -15),
            readView.heightAnchor.constraint(equalTo: jobView.heightAnchor, multiplier: 0.22),
            readView.widthAnchor.constraint(equalTo: jobView.widthAnchor, multiplier: 0.4),
        ])
    }
    
    func toolsViewSetup() {
        toolsView.addSubviews(views: [
            toolsNameLabel,
            toolsImageView,
            toolsDescriptionLabel,
        ])
        
        toolsView.addSubview(playView)
        
        NSLayoutConstraint.activate([
            toolsNameLabel.topAnchor.constraint(equalTo: toolsView.topAnchor, constant: 15),
            toolsNameLabel.leadingAnchor.constraint(equalTo: toolsView.leadingAnchor, constant: 15),
            toolsNameLabel.trailingAnchor.constraint(equalTo: toolsImageView.centerXAnchor),
            toolsNameLabel.heightAnchor.constraint(equalTo: toolsView.heightAnchor, multiplier: 0.2),
            
            toolsDescriptionLabel.topAnchor.constraint(equalTo: toolsNameLabel.bottomAnchor, constant: 5),
            toolsDescriptionLabel.leadingAnchor.constraint(equalTo: toolsView.leadingAnchor, constant: 15),
            toolsDescriptionLabel.trailingAnchor.constraint(equalTo: toolsView.centerXAnchor, constant: 15),
            toolsDescriptionLabel.heightAnchor.constraint(equalTo: toolsView.heightAnchor, multiplier: descruprionHeight),
        
            toolsImageView.trailingAnchor.constraint(equalTo: toolsView.trailingAnchor, constant: 10),
            toolsImageView.bottomAnchor.constraint(equalTo: toolsView.bottomAnchor, constant: 0),
            toolsImageView.heightAnchor.constraint(equalTo: toolsView.heightAnchor, multiplier: 1.0),
            toolsImageView.widthAnchor.constraint(equalTo: toolsView.heightAnchor, multiplier: 1.0),
            
            playView.leadingAnchor.constraint(equalTo: toolsView.leadingAnchor, constant: 15),
            playView.bottomAnchor.constraint(equalTo: toolsView.bottomAnchor, constant: -15),
            playView.heightAnchor.constraint(equalTo: toolsView.heightAnchor, multiplier: 0.22),
            playView.widthAnchor.constraint(equalTo: toolsView.widthAnchor, multiplier: 0.4),
        ])
    }
    
    func lockViewSetup() {
        lockView.addSubviews(views: [
            lockImageView,
            lockLabel
        ])
        
        NSLayoutConstraint.activate([
        lockImageView.centerYAnchor.constraint(equalTo: lockView.centerYAnchor, constant: 0),
        lockImageView.leadingAnchor.constraint(equalTo: lockView.leadingAnchor, constant: 8),
        lockImageView.heightAnchor.constraint(equalTo: lockView.heightAnchor, multiplier: 0.5),
        lockImageView.widthAnchor.constraint(equalTo: lockView.heightAnchor, multiplier: 0.5),

        lockLabel.topAnchor.constraint(equalTo: lockView.topAnchor, constant: 0),
        lockLabel.leadingAnchor.constraint(equalTo: lockImageView.trailingAnchor, constant: 5),
        lockLabel.trailingAnchor.constraint(equalTo: lockView.trailingAnchor, constant: -8),
        lockLabel.bottomAnchor.constraint(equalTo: lockView.bottomAnchor, constant: 0),
        ])
        
    }
    
    func lockViewWordSetup() {
        lockViewWord.addSubviews(views: [
            lockImageViewWord,
            lockLabelWord
        ])
        
        NSLayoutConstraint.activate([
        lockImageViewWord.centerYAnchor.constraint(equalTo: lockViewWord.centerYAnchor, constant: 0),
        lockImageViewWord.leadingAnchor.constraint(equalTo: lockViewWord.leadingAnchor, constant: 8),
        lockImageViewWord.heightAnchor.constraint(equalTo: lockViewWord.heightAnchor, multiplier: 0.5),
        lockImageViewWord.widthAnchor.constraint(equalTo: lockViewWord.heightAnchor, multiplier: 0.5),

        lockLabelWord.topAnchor.constraint(equalTo: lockViewWord.topAnchor, constant: 0),
        lockLabelWord.leadingAnchor.constraint(equalTo: lockImageViewWord.trailingAnchor, constant: 5),
        lockLabelWord.trailingAnchor.constraint(equalTo: lockViewWord.trailingAnchor, constant: -8),
        lockLabelWord.bottomAnchor.constraint(equalTo: lockViewWord.bottomAnchor, constant: 0),
        ])
        
    }
}
