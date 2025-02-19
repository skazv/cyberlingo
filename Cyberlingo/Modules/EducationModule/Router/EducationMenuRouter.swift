//
//  EducationMenuRouter.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

class EducationMenuRouter: EducationMenuRouterProtocol {
    
    static func createEducationMenuModul() -> UIViewController {
        let viewController = EducationMenuViewController()
        let presenter: EducationMenuPresenterProtocol & EducationMenuInteractorOutputProtocol = EducationMenuPresenter()
        let router: EducationMenuRouterProtocol = EducationMenuRouter()
        let interactor: EducationMenuInteractorInputProtocol = EducationMenuInteractor()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
//        presenter.delegate = delegate
        interactor.presenter = presenter
        
        return viewController
    }
    
    func presentCourseScreen(from view: EducationMenuViewProtocol, course: CourseViewModel) {
        guard let delegate = view.presenter as? CourseDelegate else { return }
        let courseVC = CourseRouter.createCourseModul(with: delegate, course: course)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("invalid protocol")
        }
        
        viewVC.navigationController?.pushViewController(courseVC, animated: true)
    }
    
    func dismissEducationMenu(from view: EducationMenuViewProtocol, completion: (() -> Void)?) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true)
        }
    }
    
}
