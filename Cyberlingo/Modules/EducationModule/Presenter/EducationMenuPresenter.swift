//
//  EducationMenuPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import Foundation

class EducationMenuPresenter: EducationMenuPresenterProtocol {
    var view: EducationMenuViewProtocol?
    var interactor: EducationMenuInteractorInputProtocol?
    var router: EducationMenuRouterProtocol?
    var delegate: EducationMenuDelegate?
    
    func openCourseScreen(course: CourseViewModel) {
        guard let view = view else { return }
        router?.presentCourseScreen(from: view, course: course)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissEducationMenu(from: view, completion: nil)
    }
    
}

//MARK: - EducationMenuInteractorOutputProtocol
extension EducationMenuPresenter: EducationMenuInteractorOutputProtocol {
    
}

//MARK: - CourseDelegate
extension EducationMenuPresenter: CourseDelegate {
    
}


