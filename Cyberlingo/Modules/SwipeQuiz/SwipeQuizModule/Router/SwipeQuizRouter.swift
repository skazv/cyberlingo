//
//  SwipeQuizRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

class SwipeQuizRouter: SwipeQuizRouterProtocol {
    static func createSwipeQuizModul(with delegate: SwipeQuizDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = SwipeQuizViewController()
        let presenter: SwipeQuizPresenterProtocol & SwipeQuizInteractorOutputProtocol = SwipeQuizPresenter()
        let router: SwipeQuizRouterProtocol = SwipeQuizRouter()
        let interactor: SwipeQuizInteractorInputProtocol = SwipeQuizInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.view?.lesson = lesson
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        return viewController
    }
    
    func presentFinishScreen(from view: SwipeQuizViewProtocol) {
        guard let delegate = view.presenter as? FinishModuleDelegate else { return }
        let finishVC = FinishModuleRouter.createFinishModuleModul(with: delegate)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        finishVC.sheetPresentationController?.detents = [.medium(), .large()]
        finishVC.sheetPresentationController?.preferredCornerRadius = 30
        finishVC.sheetPresentationController?.prefersGrabberVisible = false
        viewVC.navigationController?.present(finishVC, animated: true)
    }
    
    func dismissSwipeQuiz(from view: SwipeQuizViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
