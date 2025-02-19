//
//  CoursePresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import Foundation

class CoursePresenter: CoursePresenterProtocol {
    var view: CourseViewProtocol?
    var interactor: CourseInteractorInputProtocol?
    var router: CourseRouterProtocol?
    var delegate: CourseDelegate?
    
    func openLesson(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentLessonScreen(from: view, lesson: lesson)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissCourse(from: view, completion: nil)
    }
    
}

//MARK: - CourseInteractorOutputProtocol
extension CoursePresenter: CourseInteractorOutputProtocol {
    
}

//MARK: - CourseInteractorOutputProtocol
extension CoursePresenter: LessonDelegate {
    
}

