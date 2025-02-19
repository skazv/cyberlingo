//
//  SqlInjectionPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 10.02.25.
//

import Foundation

class SqlInjectionPresenter: SqlInjectionPresenterProtocol {
    var view: SqlInjectionViewProtocol?
    var interactor: SqlInjectionInteractorInputProtocol?
    var router: SqlInjectionRouterProtocol?
    var delegate: SqlInjectionDelegate?
    
    func openFinish() {
        guard let view = view else { return }
        router?.presentFinishScreen(from: view)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissSqlInjection(from: view, completion: nil)
    }
    
}

//MARK: - SqlInjectionInteractorOutputProtocol
extension SqlInjectionPresenter: SqlInjectionInteractorOutputProtocol {
    
}

//MARK: - FinishModuleDelegate
extension SqlInjectionPresenter: FinishModuleDelegate {
    func saveAndClose() {
        closeView()
    }
    
}

