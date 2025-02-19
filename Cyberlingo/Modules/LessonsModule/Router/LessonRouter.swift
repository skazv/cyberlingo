//
//  LessonRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

class LessonRouter: LessonRouterProtocol {
    static func createLessonModul(with delegate: LessonDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = LessonViewController()
        let presenter: LessonPresenterProtocol & LessonInteractorOutputProtocol = LessonPresenter()
        let router: LessonRouterProtocol = LessonRouter()
        let interactor: LessonInteractorInputProtocol = LessonInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.view?.lesson = lesson
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    func presentEncryptionScreen(from view: LessonViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? EncryptionDelegate else { return }
        let lessonVC = EncryptionRouter.createEncryptionModul(with: delegate, lesson: lesson)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
    func presentSwipeQuizScreen(from view: LessonViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? SwipeQuizDelegate else { return }
        let lessonVC = SwipeQuizRouter.createSwipeQuizModul(with: delegate, lesson: lesson)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
    func presentSqlInjectionScreen(from view: LessonViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? SqlInjectionDelegate else { return }
        let lessonVC = SqlInjectionRouter.createSqlInjectionModul(with: delegate, lesson: lesson)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
    func presentPasswordScreen(from view: LessonViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? PasswordDelegate else { return }
        let lessonVC = PasswordRouter.createPasswordModul(with: delegate, lesson: lesson)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
    func presentQuizQuestionScreen(from view: LessonViewProtocol, lesson: LessonViewModel) {
        guard let delegate = view.presenter as? QuizQuestionDelegate else { return }
        let lessonVC = QuizQuestionRouter.createQuizQuestionModul(with: delegate, lesson: lesson)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
    func dismissLesson(from view: LessonViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
