//
//  SqlInjectionProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 10.02.25.
//

import UIKit

protocol SqlInjectionDelegate: AnyObject {
}

protocol SqlInjectionViewProtocol: AnyObject {
    var presenter: SqlInjectionPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol SqlInjectionPresenterProtocol: AnyObject {
    var view: SqlInjectionViewProtocol? { get set }
    var interactor: SqlInjectionInteractorInputProtocol? { get set }
    var router: SqlInjectionRouterProtocol? { get set }
    var delegate: SqlInjectionDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openFinish()
    func closeView()
}

protocol SqlInjectionRouterProtocol: AnyObject {
    static func createSqlInjectionModul(with delegate: SqlInjectionDelegate, lesson: LessonViewModel) -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentFinishScreen(from view: SqlInjectionViewProtocol)
    func dismissSqlInjection(from view: SqlInjectionViewProtocol, completion: (() -> Void)?)
}

protocol SqlInjectionInteractorInputProtocol: AnyObject {
    var presenter: SqlInjectionInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol SqlInjectionInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
