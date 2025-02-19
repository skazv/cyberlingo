//
//  ToolsPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import Foundation

class ToolsPresenter: ToolsPresenterProtocol {
    var view: ToolsViewProtocol?
    var interactor: ToolsInteractorInputProtocol?
    var router: ToolsRouterProtocol?
    var delegate: ToolsDelegate?
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissTools(from: view, completion: nil)
    }
    
}

//MARK: - ToolsInteractorOutputProtocol
extension ToolsPresenter: ToolsInteractorOutputProtocol {
    
}

