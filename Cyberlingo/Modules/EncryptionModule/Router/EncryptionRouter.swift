//
//  EncryptionRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 06.02.25.
//

import UIKit

class EncryptionRouter: EncryptionRouterProtocol {
    static func createEncryptionModul(with delegate: EncryptionDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = EncryptionViewController()
        let presenter: EncryptionPresenterProtocol & EncryptionInteractorOutputProtocol = EncryptionPresenter()
        let router: EncryptionRouterProtocol = EncryptionRouter()
        let interactor: EncryptionInteractorInputProtocol = EncryptionInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.view?.lesson = lesson
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentFinishScreen(from view: EncryptionViewProtocol) {
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
    
    func dismissEncryption(from view: EncryptionViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
