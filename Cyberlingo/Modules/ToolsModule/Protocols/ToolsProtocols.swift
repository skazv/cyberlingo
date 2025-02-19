//
//  ToolsProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import UIKit

protocol ToolsDelegate: AnyObject {
}

protocol ToolsViewProtocol: AnyObject {
    var presenter: ToolsPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol ToolsPresenterProtocol: AnyObject {
    var view: ToolsViewProtocol? { get set }
    var interactor: ToolsInteractorInputProtocol? { get set }
    var router: ToolsRouterProtocol? { get set }
    var delegate: ToolsDelegate? { get set }
    
    // VIEW -> PRESENTER
    func closeView()
}

protocol ToolsRouterProtocol: AnyObject {
    static func createToolsModul(with delegate: ToolsDelegate) -> UIViewController
    
    // PRESENTER -> ROUTER
    func dismissTools(from view: ToolsViewProtocol, completion: (() -> Void)?)
}

protocol ToolsInteractorInputProtocol: AnyObject {
    var presenter: ToolsInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ToolsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
