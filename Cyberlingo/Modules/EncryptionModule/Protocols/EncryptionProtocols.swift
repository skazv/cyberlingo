//
//  EncryptionProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 06.02.25.
//

import UIKit

protocol EncryptionDelegate: AnyObject {
}

protocol EncryptionViewProtocol: AnyObject {
    var presenter: EncryptionPresenterProtocol? { get set }
    var lesson: LessonViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol EncryptionPresenterProtocol: AnyObject {
    var view: EncryptionViewProtocol? { get set }
    var interactor: EncryptionInteractorInputProtocol? { get set }
    var router: EncryptionRouterProtocol? { get set }
    var delegate: EncryptionDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openFinish()
    func closeView()
}

protocol EncryptionRouterProtocol: AnyObject {
    static func createEncryptionModul(with delegate: EncryptionDelegate, lesson: LessonViewModel) -> UIViewController

    // PRESENTER -> ROUTER
    func presentFinishScreen(from view: EncryptionViewProtocol)
    func dismissEncryption(from view: EncryptionViewProtocol, completion: (() -> Void)?)
}

protocol EncryptionInteractorInputProtocol: AnyObject {
    var presenter: EncryptionInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol EncryptionInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
