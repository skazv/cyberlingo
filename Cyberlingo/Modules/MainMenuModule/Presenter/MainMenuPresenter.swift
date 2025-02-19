//
//  MainMenuPresenter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//

import Foundation

class MainMenuPresenter: MainMenuPresenterProtocol {
    var view: MainMenuViewProtocol?
    var interactor: MainMenuInteractorInputProtocol?
    var router: MainMenuRouterProtocol?
    var delegate: MainMenuDelegate?
    
    func viewDidLoad() {
    }
    
    func openEducationBoard() {
        guard let view = view else { return }
        router?.presentEducationScreen(from: view)
    }
    
    func openCertificateBoard() {
        guard let view = view else { return }
        router?.presentCertificateBoardScreen(from: view, course: Courses.certificates[0])
    }
    
    func openJobBoard() {
        guard let view = view else { return }
        router?.presentJobBoardScreen(from: view)
    }
    
    func openToolsBoard() {
        guard let view = view else { return }
        router?.presentToolsBoardScreen(from: view)
    }
    
    func openAbout() {
        guard let view = view else { return }
        router?.presentAboutScreen(from: view)
    }
    
    func openProfile() {
        guard let view = view else { return }
        router?.presentProfileScreen(from: view)
    }
    
    func openPayWall() {
        guard let view = view else { return }
        router?.presentPayWallScreen(from: view)
    }
    
    
    func closeView() {
        guard let view = view else { return }
        router?.dismissMainMenu(from: view, completion: nil)
    }
    
}

//MARK: - MainMenuInteractorOutputProtocol
extension MainMenuPresenter: MainMenuInteractorOutputProtocol {
    
}

//MARK: - EducationMenuDelegate
extension MainMenuPresenter: EducationMenuDelegate {
    
}

//MARK: - EducationMenuDelegate
extension MainMenuPresenter: CourseDelegate {
    
}

//MARK: - ToolsDelegate
extension MainMenuPresenter: ToolsDelegate {
    
}
