//
//  LessonProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

protocol LessonDelegate: AnyObject {
}

protocol LessonViewProtocol: AnyObject {
    var presenter: LessonPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol LessonPresenterProtocol: AnyObject {
    var view: LessonViewProtocol? { get set }
    var interactor: LessonInteractorInputProtocol? { get set }
    var router: LessonRouterProtocol? { get set }
    var delegate: LessonDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openEncryption(lesson: LessonViewModel)
    func openSwipeQuiz(lesson: LessonViewModel)
    func openSqlInjection(lesson: LessonViewModel)
    func openPassword(lesson: LessonViewModel)
    func openQuizQuestion(lesson: LessonViewModel)
    func closeView()
}

protocol LessonRouterProtocol: AnyObject {
    static func createLessonModul(with delegate: LessonDelegate, lesson: LessonViewModel) -> UIViewController

    // PRESENTER -> ROUTER
    func presentQuizQuestionScreen(from view: LessonViewProtocol, lesson: LessonViewModel)
    func presentSwipeQuizScreen(from view: LessonViewProtocol, lesson: LessonViewModel)
    func presentSqlInjectionScreen(from view: LessonViewProtocol, lesson: LessonViewModel)
    func presentEncryptionScreen(from view: LessonViewProtocol, lesson: LessonViewModel)
    func presentPasswordScreen(from view: LessonViewProtocol, lesson: LessonViewModel)
    func dismissLesson(from view: LessonViewProtocol, completion: (() -> Void)?)
}

protocol LessonInteractorInputProtocol: AnyObject {
    var presenter: LessonInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol LessonInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
