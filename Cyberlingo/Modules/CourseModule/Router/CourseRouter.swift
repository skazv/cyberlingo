//
//  CourseRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

class CourseRouter: CourseRouterProtocol {
    static func createCourseModul(with delegate: CourseDelegate, course: CourseViewModel) -> UIViewController {
        let viewController = CourseViewController()
        let presenter: CoursePresenterProtocol & CourseInteractorOutputProtocol = CoursePresenter()
        let router: CourseRouterProtocol = CourseRouter()
        let interactor: CourseInteractorInputProtocol = CourseInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        presenter.view?.course = course
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentLessonScreen(from view: CourseViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? LessonDelegate else { return }
        let lessonVC = UINavigationController(rootViewController: LessonRouter.createLessonModul(with: delegate, lesson: lesson))
        
        guard let viewVC = view as? UIViewController else { return }
        lessonVC.modalPresentationStyle = .fullScreen
        viewVC.navigationController?.present(lessonVC, animated: true)
    }
    
    func dismissCourse(from view: CourseViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
