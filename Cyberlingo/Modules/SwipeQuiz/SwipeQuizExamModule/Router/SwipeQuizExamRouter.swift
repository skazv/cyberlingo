//
//  SwipeQuizExamRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

class SwipeQuizExamRouter: SwipeQuizExamRouterProtocol {
    static func createSwipeQuizExamModul(with delegate: SwipeQuizExamDelegate) -> UIViewController {
        let viewController = SwipeQuizExamViewController()
        let presenter: SwipeQuizExamPresenterProtocol & SwipeQuizExamInteractorOutputProtocol = SwipeQuizExamPresenter()
        let router: SwipeQuizExamRouterProtocol = SwipeQuizExamRouter()
        let interactor: SwipeQuizExamInteractorInputProtocol = SwipeQuizExamInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissSwipeQuizExam(from view: SwipeQuizExamViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
