//
//  QuizQuestionProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

protocol QuizQuestionDelegate: AnyObject {
}

protocol QuizQuestionViewProtocol: AnyObject {
    var presenter: QuizQuestionPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol QuizQuestionPresenterProtocol: AnyObject {
    var view: QuizQuestionViewProtocol? { get set }
    var interactor: QuizQuestionInteractorInputProtocol? { get set }
    var router: QuizQuestionRouterProtocol? { get set }
    var delegate: QuizQuestionDelegate? { get set }
    
    // VIEW -> PRESENTER
    func closeView()
}

protocol QuizQuestionRouterProtocol: AnyObject {
    static func createQuizQuestionModul(with delegate: QuizQuestionDelegate, lesson: LessonViewModel) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissQuizQuestion(from view: QuizQuestionViewProtocol, completion: (() -> Void)?)
}

protocol QuizQuestionInteractorInputProtocol: AnyObject {
    var presenter: QuizQuestionInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol QuizQuestionInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
