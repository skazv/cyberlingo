//
//  LessonViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit

class LessonViewController: UIViewController {
    let lessonView = LessonView()
    var presenter: LessonPresenterProtocol?
    var lesson: LessonViewModel?
    
    override func loadView() {
        super.loadView()
        view = lessonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if let lesson = lesson {
            if lesson.lessonType == .quizQuestion {
                presenter?.openQuizQuestion(lesson: lesson)
            }
        }
    }
    
}

//MARK: - Private methods
extension LessonViewController {
    private func setup() {
        guard let lesson = lesson else { return }
        title = lesson.name
        navigationController?.navigationBar.tintColor = UIColor().hexStringToUIColor(hex: "466CFF")
        lessonView.imageView.image = UIImage(named: lesson.view1image ?? lesson.imageName)
        lessonView.nameLabel.text = lesson.view1name
        lessonView.descriptionLabel.text = lesson.view1description
        lessonView.nameLabel2.text = lesson.view1name
        lessonView.descriptionLabel2.text = lesson.view1description
        let closeImage = UIImage(systemName: "xmark")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closePressed))
        lessonView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        lessonView.loadYouTubeVideo(videoID: lesson.view1videoUrl ?? "")
    }
   
    @objc func nextPressed() {
        if let lesson = lesson {
            switch lesson.lessonType {
            case .encryption, .ceaserEncryption, .symmetricEncryption:
                presenter?.openEncryption(lesson: lesson)
            case .swipeQuiz:
                presenter?.openSwipeQuiz(lesson: lesson)
            case .sqlInjection:
                presenter?.openSqlInjection(lesson: lesson)
            case .quizQuestion:
                presenter?.openQuizQuestion(lesson: lesson)
            case .password:
                presenter?.openPassword(lesson: lesson)
            default:
                presenter?.openSwipeQuiz(lesson: lesson)
            }
        }
    }
    
    @objc func closePressed() {
        presenter?.closeView()
    }
}


//MARK: - LessonViewProtocol
extension LessonViewController: LessonViewProtocol {
}
