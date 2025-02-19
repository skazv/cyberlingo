//
//  FinishModuleProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

protocol FinishModuleDelegate: AnyObject {
    func saveAndClose()
}

protocol FinishModuleViewProtocol: AnyObject {
    var presenter: FinishModulePresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol FinishModulePresenterProtocol: AnyObject {
    var view: FinishModuleViewProtocol? { get set }
    var interactor: FinishModuleInteractorInputProtocol? { get set }
    var router: FinishModuleRouterProtocol? { get set }
    var delegate: FinishModuleDelegate? { get set }
    
    // VIEW -> PRESENTER
    func closeView()
}

protocol FinishModuleRouterProtocol: AnyObject {
    static func createFinishModuleModul(with delegate: FinishModuleDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissFinishModule(from view: FinishModuleViewProtocol, completion: (() -> Void)?)
}

protocol FinishModuleInteractorInputProtocol: AnyObject {
    var presenter: FinishModuleInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol FinishModuleInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
