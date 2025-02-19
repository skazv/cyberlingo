//
//  SwipeQuizProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

protocol SwipeQuizDelegate: AnyObject {
}

protocol SwipeQuizViewProtocol: AnyObject {
    var presenter: SwipeQuizPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol SwipeQuizPresenterProtocol: AnyObject {
    var view: SwipeQuizViewProtocol? { get set }
    var interactor: SwipeQuizInteractorInputProtocol? { get set }
    var router: SwipeQuizRouterProtocol? { get set }
    var delegate: SwipeQuizDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openFinish()
    func closeView()
}

protocol SwipeQuizRouterProtocol: AnyObject {
    static func createSwipeQuizModul(with delegate: SwipeQuizDelegate, lesson: LessonViewModel) -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentFinishScreen(from view: SwipeQuizViewProtocol)
    func dismissSwipeQuiz(from view: SwipeQuizViewProtocol, completion: (() -> Void)?)
}

protocol SwipeQuizInteractorInputProtocol: AnyObject {
    var presenter: SwipeQuizInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol SwipeQuizInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
