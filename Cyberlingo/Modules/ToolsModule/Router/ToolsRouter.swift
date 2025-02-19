//
//  ToolsRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import UIKit

class ToolsRouter: ToolsRouterProtocol {
    static func createToolsModul(with delegate: ToolsDelegate) -> UIViewController {
        let viewController = ToolsViewController()
        let presenter: ToolsPresenterProtocol & ToolsInteractorOutputProtocol = ToolsPresenter()
        let router: ToolsRouterProtocol = ToolsRouter()
        let interactor: ToolsInteractorInputProtocol = ToolsInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func dismissTools(from view: ToolsViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
