//
//  MainMenuProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//

import UIKit

protocol MainMenuDelegate: AnyObject {
}

protocol MainMenuViewProtocol: AnyObject {
    var presenter: MainMenuPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol MainMenuPresenterProtocol: AnyObject {
    var view: MainMenuViewProtocol? { get set }
    var interactor: MainMenuInteractorInputProtocol? { get set }
    var router: MainMenuRouterProtocol? { get set }
    var delegate: MainMenuDelegate? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func openEducationBoard()
    func openCertificateBoard()
    func openJobBoard()
    func openToolsBoard()
    func openAbout()
    func openProfile()
    func openPayWall()
    func closeView()
}

protocol MainMenuRouterProtocol: AnyObject {
    static func createMainMenuModul() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentEducationScreen(from view: MainMenuViewProtocol)
    func presentCertificateBoardScreen(from view: MainMenuViewProtocol, course: CourseViewModel)
    func presentJobBoardScreen(from view: MainMenuViewProtocol)
    func presentToolsBoardScreen(from view: MainMenuViewProtocol)
    func presentAboutScreen(from view: MainMenuViewProtocol)
    func presentProfileScreen(from view: MainMenuViewProtocol)
    func presentPayWallScreen(from view: MainMenuViewProtocol)
    func dismissMainMenu(from view: MainMenuViewProtocol, completion: (() -> Void)?)
}

protocol MainMenuInteractorInputProtocol: AnyObject {
    var presenter: MainMenuInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol MainMenuInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
