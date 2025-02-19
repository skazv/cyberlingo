//
//  CourseViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

class CourseViewController: UIViewController {
    let courseView = CourseView()
    var presenter: CoursePresenterProtocol?
    var course: CourseViewModel?
    
    override func loadView() {
        super.loadView()
        view = courseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if let course = course {
            didFetchCourse(courseVM: course)
        }
    }
    
}

//MARK: - Private methods
extension CourseViewController {
    private func setup() {
        guard let course = course else { return }
        courseView.courseCollection.courseCollectionCellDelegate = self
        courseView.courseCollection.courseVM = course
    }
    
    func didFetchCourse(courseVM: CourseViewModel) {
        course = courseVM
        let lessons = courseVM.lessons
        courseView.courseCollection.courseVM?.lessons = lessons
        course?.lessons = lessons
        courseView.courseCollection.reloadData()
    }
}


//MARK: - CourseViewProtocol
extension CourseViewController: CourseViewProtocol {
}

//MARK: - CourseViewProtocol
extension CourseViewController: CourseCollectionCellDelegate {
    func cellTaped(number: Int) {
        if let lesson = course?.lessons[number] {
            if lesson.isBlocked == true {
                showAlarm(title: "", message: "Blocked!")
            } else {
                presenter?.openLesson(lesson: lesson)
            }
        }
    }
}
