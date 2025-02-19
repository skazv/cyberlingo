//
//  EducationMenuProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

protocol EducationMenuDelegate: AnyObject {
}

protocol EducationMenuViewProtocol: AnyObject {
    var presenter: EducationMenuPresenterProtocol? { get set }

    // PRESENTER -> VIEW
}

protocol EducationMenuPresenterProtocol: AnyObject {
    var view: EducationMenuViewProtocol? { get set }
    var interactor: EducationMenuInteractorInputProtocol? { get set }
    var router: EducationMenuRouterProtocol? { get set }
    var delegate: EducationMenuDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openCourseScreen(course: CourseViewModel)
    func closeView()
}

protocol EducationMenuRouterProtocol: AnyObject {
    static func createEducationMenuModul() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentCourseScreen(from view: EducationMenuViewProtocol, course: CourseViewModel)
    func dismissEducationMenu(from view: EducationMenuViewProtocol, completion: (() -> Void)?)
}

protocol EducationMenuInteractorInputProtocol: AnyObject {
    var presenter: EducationMenuInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol EducationMenuInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
