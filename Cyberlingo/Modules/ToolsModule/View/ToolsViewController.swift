//
//  ToolsViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import UIKit

class ToolsViewController: UIViewController {
    let toolsView = ToolsView()
    var presenter: ToolsPresenterProtocol?
    var lessons: [LessonViewModel] = [
        LessonViewModel(id: 0, lessonType: .ceaserEncryption, name: "AI image detecter", imageName: "artInt", view1image: "artInt", view1name: "artInt", view1videoUrl: "artInt", view1description: "artInt", isBlocked: false, isExamPassed: true, color: "9E4AE3", description: "Identify AI-generated content using analysis tool", contentLesson: [], quizQuestions: []),
        LessonViewModel(id: 0, lessonType: .ceaserEncryption, name: "Checking for leaks", imageName: "artInt", view1image: "artInt", view1name: "artInt", view1videoUrl: "artInt", view1description: "artInt", isBlocked: false, isExamPassed: true, color: "9E4AE3", description: "Check your email to find any leaks", contentLesson: [], quizQuestions: []),
        LessonViewModel(id: 0, lessonType: .ceaserEncryption, name: "AI chat (helper)", imageName: "artInt", view1image: "artInt", view1name: "artInt", view1videoUrl: "artInt", view1description: "artInt", isBlocked: false, isExamPassed: true, color: "9E4AE3", description: "Ask questions to your AI mentor", contentLesson: [], quizQuestions: []),
        ]

    override func loadView() {
        super.loadView()
        view = toolsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension ToolsViewController {
    private func setup() {
        toolsView.courseCollection.courseCollectionCellDelegate = self
        toolsView.courseCollection.lessons = lessons
    }
}


//MARK: - ToolsViewProtocol
extension ToolsViewController: ToolsViewProtocol {
}

//MARK: - CourseViewProtocol
extension ToolsViewController: CourseCollectionCellDelegate {
    func cellTaped(number: Int) {
        switch number {
        case 0:
            self.navigationController?.pushViewController(ImageCheckViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(BreachCheckViewController(), animated: true)
        default:
            self.navigationController?.pushViewController(ChatViewController(), animated: true)
        }
    }
}
