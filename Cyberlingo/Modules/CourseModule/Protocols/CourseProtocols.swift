//
//  CourseProtocols.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

protocol CourseDelegate: AnyObject {
}

protocol CourseViewProtocol: AnyObject {
    var presenter: CoursePresenterProtocol? { get set }
    var course: CourseViewModel? { get set }

    // PRESENTER -> VIEW
}

protocol CoursePresenterProtocol: AnyObject {
    var view: CourseViewProtocol? { get set }
    var interactor: CourseInteractorInputProtocol? { get set }
    var router: CourseRouterProtocol? { get set }
    var delegate: CourseDelegate? { get set }
    
    // VIEW -> PRESENTER
    func openLesson(lesson: LessonViewModel)
    func closeView()
}

protocol CourseRouterProtocol: AnyObject {
    static func createCourseModul(with delegate: CourseDelegate, course: CourseViewModel) -> UIViewController

    // PRESENTER -> ROUTER
    func presentLessonScreen(from view: CourseViewProtocol, lesson: LessonViewModel)
    func dismissCourse(from view: CourseViewProtocol, completion: (() -> Void)?)
}

protocol CourseInteractorInputProtocol: AnyObject {
    var presenter: CourseInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol CourseInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
