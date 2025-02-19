//
//  FinishModulePresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import Foundation

class FinishModulePresenter: FinishModulePresenterProtocol {
    var view: FinishModuleViewProtocol?
    var interactor: FinishModuleInteractorInputProtocol?
    var router: FinishModuleRouterProtocol?
    var delegate: FinishModuleDelegate?
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissFinishModule(from: view, completion: nil)
        delegate?.saveAndClose()
    }
    
}

//MARK: - FinishModuleInteractorOutputProtocol
extension FinishModulePresenter: FinishModuleInteractorOutputProtocol {
    
}

