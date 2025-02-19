//
//  MainMenuRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//

import UIKit

class MainMenuRouter: MainMenuRouterProtocol {
    static func createMainMenuModul() -> UIViewController {
        let viewController = MainMenuViewController()
        let presenter: MainMenuPresenterProtocol & MainMenuInteractorOutputProtocol = MainMenuPresenter()
        let router: MainMenuRouterProtocol = MainMenuRouter()
        let interactor: MainMenuInteractorInputProtocol = MainMenuInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
//        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentEducationScreen(from view: any MainMenuViewProtocol) {
        let educationVC = EducationMenuRouter.createEducationMenuModul()
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        viewVC.navigationController?.pushViewController(educationVC, animated: true)
    }
    
    func presentCertificateBoardScreen(from view: any MainMenuViewProtocol, course: CourseViewModel) {
        guard let delegate = view.presenter as? CourseDelegate else { return }
        let courseVC = CourseRouter.createCourseModul(with: delegate, course: course)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        viewVC.navigationController?.pushViewController(courseVC, animated: true)
    }
    
    func presentToolsBoardScreen(from view: any MainMenuViewProtocol) {
        guard let delegate = view.presenter as? ToolsDelegate else { return }
        let courseVC = ToolsRouter.createToolsModul(with: delegate)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        viewVC.navigationController?.pushViewController(courseVC, animated: true)
    }
    
    func presentJobBoardScreen(from view: any MainMenuViewProtocol) {
        //        let educationVC = EducationMenuRouter.createEducationMenuModul()
        //
        //        guard let viewVC = view as? UIViewController else {
        //            fatalError("invalid protocol")
        //        }
        //
        //        viewVC.navigationController?.pushViewController(educationVC, animated: true)
    }
    
    func presentAboutScreen(from view: any MainMenuViewProtocol) {
        //        let educationVC = EducationMenuRouter.createEducationMenuModul()
        //
        //        guard let viewVC = view as? UIViewController else {
        //            fatalError("invalid protocol")
        //        }
        //
        //        viewVC.navigationController?.pushViewController(educationVC, animated: true)
    }
    
    func presentProfileScreen(from view: any MainMenuViewProtocol) {
        //        let educationVC = EducationMenuRouter.createEducationMenuModul()
        //
        //        guard let viewVC = view as? UIViewController else {
        //            fatalError("invalid protocol")
        //        }
        //
        //        viewVC.navigationController?.pushViewController(educationVC, animated: true)
    }
    
    func presentPayWallScreen(from view: any MainMenuViewProtocol) {
        //        let educationVC = EducationMenuRouter.createEducationMenuModul()
        //
        //        guard let viewVC = view as? UIViewController else {
        //            fatalError("invalid protocol")
        //        }
        //
        //        viewVC.navigationController?.pushViewController(educationVC, animated: true)
    }
    
    func dismissMainMenu(from view: MainMenuViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
