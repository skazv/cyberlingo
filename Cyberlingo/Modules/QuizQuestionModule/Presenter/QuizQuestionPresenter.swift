//
//  QuizQuestionPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import Foundation

class QuizQuestionPresenter: QuizQuestionPresenterProtocol {
    var view: QuizQuestionViewProtocol?
    var interactor: QuizQuestionInteractorInputProtocol?
    var router: QuizQuestionRouterProtocol?
    var delegate: QuizQuestionDelegate?
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissQuizQuestion(from: view, completion: nil)
    }
    
}

//MARK: - QuizQuestionInteractorOutputProtocol
extension QuizQuestionPresenter: QuizQuestionInteractorOutputProtocol {
    
}

