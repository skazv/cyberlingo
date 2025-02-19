//
//  SwipeQuizExamProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

protocol SwipeQuizExamDelegate: AnyObject {
}

protocol SwipeQuizExamViewProtocol: AnyObject {
    var presenter: SwipeQuizExamPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol SwipeQuizExamPresenterProtocol: AnyObject {
    var view: SwipeQuizExamViewProtocol? { get set }
    var interactor: SwipeQuizExamInteractorInputProtocol? { get set }
    var router: SwipeQuizExamRouterProtocol? { get set }
    var delegate: SwipeQuizExamDelegate? { get set }
    
    // VIEW -> PRESENTER
    func closeView()
}

protocol SwipeQuizExamRouterProtocol: AnyObject {
    static func createSwipeQuizExamModul(with delegate: SwipeQuizExamDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissSwipeQuizExam(from view: SwipeQuizExamViewProtocol, completion: (() -> Void)?)
}

protocol SwipeQuizExamInteractorInputProtocol: AnyObject {
    var presenter: SwipeQuizExamInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol SwipeQuizExamInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
