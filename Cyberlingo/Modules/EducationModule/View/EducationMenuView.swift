//
//  EducationMenuView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

class EducationMenuView: UIView {
    let educationCollection = EducationCollection()
    let userCourseCollection = UserCourseCollection()
    
    private lazy var courseLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var courseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Arial Bold", size: 14)
        label.text = LocalisationManager.courses
        return label
    }()
    
    lazy var orderButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = .systemOrange
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        view.layer.shadowRadius = 4.0
        view.layer.cornerRadius = 15.0
        
        return view
    }()
    
    private lazy var userCourseLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var userCourseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "Arial Bold", size: 14)
        label.text = LocalisationManager.customCourses//"СОБСТВЕННЫЕ КУРСЫ"
        return label
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
extension EducationMenuView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubviews(views: [
            courseLabelView,
            educationCollection,
            userCourseLabelView,
            userCourseCollection,
        ])
        
        courseLabelView.addSubview(courseLabel)
        userCourseLabelView.addSubview(userCourseLabel)
        
        NSLayoutConstraint.activate([
            
            courseLabelView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            courseLabelView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            courseLabelView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            courseLabelView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.04),

            educationCollection.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 0),
            educationCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            educationCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            educationCollection.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.55),
            
            userCourseLabelView.topAnchor.constraint(equalTo: educationCollection.bottomAnchor, constant: 14),
            userCourseLabelView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            userCourseLabelView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.49),
            userCourseLabelView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.04),
            
            userCourseCollection.topAnchor.constraint(equalTo: userCourseLabelView.bottomAnchor, constant: 0),
            userCourseCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            userCourseCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            userCourseCollection.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            
        ])
        
        NSLayoutConstraint.activate([
            
            courseLabel.centerXAnchor.constraint(equalTo: courseLabelView.centerXAnchor),
            courseLabel.centerYAnchor.constraint(equalTo: courseLabelView.centerYAnchor),
            courseLabel.heightAnchor.constraint(equalTo: courseLabelView.heightAnchor),
            courseLabel.widthAnchor.constraint(equalTo: courseLabelView.widthAnchor),

            userCourseLabel.centerXAnchor.constraint(equalTo: userCourseLabelView.centerXAnchor),
            userCourseLabel.centerYAnchor.constraint(equalTo: userCourseLabelView.centerYAnchor),
            userCourseLabel.heightAnchor.constraint(equalTo: userCourseLabelView.heightAnchor),
            userCourseLabel.widthAnchor.constraint(equalTo: userCourseLabelView.widthAnchor),
            
        ])
        
    }
}
