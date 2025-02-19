//
//  PasswordPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 13.02.25.
//

import Foundation

class PasswordPresenter: PasswordPresenterProtocol {
    var view: PasswordViewProtocol?
    var interactor: PasswordInteractorInputProtocol?
    var router: PasswordRouterProtocol?
    var delegate: PasswordDelegate?
    
    func openFinish() {
        guard let view = view else { return }
        router?.presentFinishScreen(from: view)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissPassword(from: view, completion: nil)
    }
    
}

//MARK: - PasswordInteractorOutputProtocol
extension PasswordPresenter: PasswordInteractorOutputProtocol {
    
}

//MARK: - FinishModuleDelegate
extension PasswordPresenter: FinishModuleDelegate {
    func saveAndClose() {
        closeView()
    }
    
}

