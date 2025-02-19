//
//  SwipeQuizPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import Foundation

class SwipeQuizPresenter: SwipeQuizPresenterProtocol {
    var view: SwipeQuizViewProtocol?
    var interactor: SwipeQuizInteractorInputProtocol?
    var router: SwipeQuizRouterProtocol?
    var delegate: SwipeQuizDelegate?
    
    func openFinish() {
        guard let view = view else { return }
        router?.presentFinishScreen(from: view)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissSwipeQuiz(from: view, completion: nil)
    }
    
}

//MARK: - SwipeQuizInteractorOutputProtocol
extension SwipeQuizPresenter: SwipeQuizInteractorOutputProtocol {
    
}

//MARK: - FinishModuleDelegate
extension SwipeQuizPresenter: FinishModuleDelegate {
    func saveAndClose() {
        closeView()
    }
    
}

