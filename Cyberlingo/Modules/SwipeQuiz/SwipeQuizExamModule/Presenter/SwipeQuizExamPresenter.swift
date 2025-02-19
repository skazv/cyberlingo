//
//  SwipeQuizExamPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import Foundation

class SwipeQuizExamPresenter: SwipeQuizExamPresenterProtocol {
    var view: SwipeQuizExamViewProtocol?
    var interactor: SwipeQuizExamInteractorInputProtocol?
    var router: SwipeQuizExamRouterProtocol?
    var delegate: SwipeQuizExamDelegate?
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissSwipeQuizExam(from: view, completion: nil)
    }
    
}

//MARK: - SwipeQuizExamInteractorOutputProtocol
extension SwipeQuizExamPresenter: SwipeQuizExamInteractorOutputProtocol {
    
}

