//
//  QuizQuestionRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class QuizQuestionRouter: QuizQuestionRouterProtocol {
    static func createQuizQuestionModul(with delegate: QuizQuestionDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = QuizQuestionViewController()
        let presenter: QuizQuestionPresenterProtocol & QuizQuestionInteractorOutputProtocol = QuizQuestionPresenter()
        let router: QuizQuestionRouterProtocol = QuizQuestionRouter()
        let interactor: QuizQuestionInteractorInputProtocol = QuizQuestionInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.view?.lesson = lesson
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissQuizQuestion(from view: QuizQuestionViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
