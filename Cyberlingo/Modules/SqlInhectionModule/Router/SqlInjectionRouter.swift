//
//  SqlInjectionRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 10.02.25.
//

import UIKit

class SqlInjectionRouter: SqlInjectionRouterProtocol {
    static func createSqlInjectionModul(with delegate: SqlInjectionDelegate, lesson: LessonViewModel) -> UIViewController {
        let viewController = SqlInjectionViewController()
        let presenter: SqlInjectionPresenterProtocol & SqlInjectionInteractorOutputProtocol = SqlInjectionPresenter()
        let router: SqlInjectionRouterProtocol = SqlInjectionRouter()
        let interactor: SqlInjectionInteractorInputProtocol = SqlInjectionInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.view?.lesson = lesson
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentFinishScreen(from view: SqlInjectionViewProtocol) {
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
    
    func dismissSqlInjection(from view: SqlInjectionViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
