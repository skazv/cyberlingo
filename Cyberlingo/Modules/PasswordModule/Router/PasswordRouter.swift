//
//  PasswordRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 13.02.25.
//

import UIKit

class PasswordRouter: PasswordRouterProtocol {
    static func createPasswordModul(with delegate: PasswordDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = PasswordViewController()
        let presenter: PasswordPresenterProtocol & PasswordInteractorOutputProtocol = PasswordPresenter()
        let router: PasswordRouterProtocol = PasswordRouter()
        let interactor: PasswordInteractorInputProtocol = PasswordInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.view?.lesson = lesson
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentFinishScreen(from view: PasswordViewProtocol) {
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
    
    func dismissPassword(from view: PasswordViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
