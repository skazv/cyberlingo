//
//  FinishModuleRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class FinishModuleRouter: FinishModuleRouterProtocol {
    static func createFinishModuleModul(with delegate: FinishModuleDelegate) -> UIViewController {
        let viewController = FinishModuleViewController()
        let presenter: FinishModulePresenterProtocol & FinishModuleInteractorOutputProtocol = FinishModulePresenter()
        let router: FinishModuleRouterProtocol = FinishModuleRouter()
        let interactor: FinishModuleInteractorInputProtocol = FinishModuleInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissFinishModule(from view: FinishModuleViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
