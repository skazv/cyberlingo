//
//  PasswordProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 13.02.25.
//

import UIKit

protocol PasswordDelegate: AnyObject {
}

protocol PasswordViewProtocol: AnyObject {
    var presenter: PasswordPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol PasswordPresenterProtocol: AnyObject {
    var view: PasswordViewProtocol? { get set }
    var interactor: PasswordInteractorInputProtocol? { get set }
    var router: PasswordRouterProtocol? { get set }
    var delegate: PasswordDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openFinish()
    func closeView()
}

protocol PasswordRouterProtocol: AnyObject {
    static func createPasswordModul(with delegate: PasswordDelegate, lesson: LessonViewModel) -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentFinishScreen(from view: PasswordViewProtocol)
    func dismissPassword(from view: PasswordViewProtocol, completion: (() -> Void)?)
}

protocol PasswordInteractorInputProtocol: AnyObject {
    var presenter: PasswordInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol PasswordInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
