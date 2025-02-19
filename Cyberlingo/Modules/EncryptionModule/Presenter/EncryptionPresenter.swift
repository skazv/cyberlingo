//
//  EncryptionPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 06.02.25.
//

import Foundation

class EncryptionPresenter: EncryptionPresenterProtocol {
    var view: EncryptionViewProtocol?
    var interactor: EncryptionInteractorInputProtocol?
    var router: EncryptionRouterProtocol?
    var delegate: EncryptionDelegate?
    
    func openFinish() {
        guard let view = view else { return }
        router?.presentFinishScreen(from: view)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissEncryption(from: view, completion: nil)
    }
    
}

//MARK: - EncryptionInteractorOutputProtocol
extension EncryptionPresenter: EncryptionInteractorOutputProtocol {
    
}

//MARK: - FinishModuleDelegate
extension EncryptionPresenter: FinishModuleDelegate {
    func saveAndClose() {
        closeView()
    }
    
}

