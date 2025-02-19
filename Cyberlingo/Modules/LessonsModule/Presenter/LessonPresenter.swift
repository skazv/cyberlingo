//
//  LessonPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import Foundation

class LessonPresenter: LessonPresenterProtocol {
    var view: LessonViewProtocol?
    var interactor: LessonInteractorInputProtocol?
    var router: LessonRouterProtocol?
    var delegate: LessonDelegate?
    
    func openSwipeQuiz(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentSwipeQuizScreen(from: view, lesson: lesson)
    }
    
    func openQuizQuestion(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentQuizQuestionScreen(from: view, lesson: lesson)
    }
    
    func openSqlInjection(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentSqlInjectionScreen(from: view, lesson: lesson)
    }
    
    func openEncryption(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentEncryptionScreen(from: view, lesson: lesson)
    }
    
    func openPassword(lesson: LessonViewModel) {
        guard let view = view else { return }
        router?.presentPasswordScreen(from: view, lesson: lesson)
    }
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissLesson(from: view, completion: nil)
    }
    
}

//MARK: - LessonInteractorOutputProtocol
extension LessonPresenter: LessonInteractorOutputProtocol {
    
}

//MARK: - SwipeQuizDelegate
extension LessonPresenter: SwipeQuizDelegate {
    
}

//MARK: - EncryptionDelegate
extension LessonPresenter: EncryptionDelegate {
    
}


//MARK: - SqlInjectionDelegate
extension LessonPresenter: SqlInjectionDelegate {
    
}


//MARK: - PasswordDelegate
extension LessonPresenter: PasswordDelegate {
    
}

//MARK: - QuizQuestionDelegate
extension LessonPresenter: QuizQuestionDelegate {
    
}

