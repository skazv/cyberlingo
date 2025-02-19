//
//  EducationMenuViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

class EducationMenuViewController: UIViewController {
    let educationMenuView = EducationMenuView()
    var presenter: EducationMenuPresenterProtocol?
    
    override func loadView() {
        super.loadView()
        view = educationMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension EducationMenuViewController {
    private func setup() {
        title = LocalisationManager.trainingCourse
        educationMenuView.educationCollection.callback = { id in
            let selectedCourse = self.educationMenuView.educationCollection.coursesVM[id]
            if id < 2 {
                self.presenter?.openCourseScreen(course: selectedCourse)
            } else {
                self.showAlarm(title: LocalisationManager.message, message: LocalisationManager.courseLockAlarm)
            }
        }
    }
}


//MARK: - EducationMenuViewProtocol
extension EducationMenuViewController: EducationMenuViewProtocol {
}
