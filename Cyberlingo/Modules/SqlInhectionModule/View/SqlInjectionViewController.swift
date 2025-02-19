//
//  SqlInjectionViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 10.02.25.
//

import UIKit

class SqlInjectionViewController: UIViewController {
    let sqlInjectionView = SqlInjectionView()
    var presenter: SqlInjectionPresenterProtocol?
    var lesson: LessonViewModel?
    var count: Int = 0
    
    override func loadView() {
        super.loadView()
        view = sqlInjectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension SqlInjectionViewController {
    private func setup() {
        guard let lesson = lesson else { return }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyToClipboard))
        sqlInjectionView.copyButton.addGestureRecognizer(tapGesture)
        
        if let url = URL(string: lesson.contentLesson[count].name) {
            sqlInjectionView.webView.load(URLRequest(url: url))
        }
        sqlInjectionView.rightButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        sqlInjectionView.titleLabel.text = lesson.contentLesson[0].translate
        sqlInjectionView.descriptionLabel.text = "Use this command to try:\n \(lesson.contentLesson[0].transcription)"
    }
    
    @objc private func nextTapped() {
        guard let lesson = lesson else { return }
        count += 1;
        if (count < lesson.contentLesson.count) {
            if let url = URL(string: lesson.contentLesson[count].name) {
                sqlInjectionView.webView.load(URLRequest(url: url))
            }
        }
        else {
            self.showConfetti()
            presenter?.openFinish()
        }
    }
    
    @objc private func copyToClipboard() {
        guard let lesson = lesson else { return }
        UIPasteboard.general.string = lesson.contentLesson[0].transcription
        self.showAlarm(title: "", message: "Copied")
    }
}


//MARK: - SqlInjectionViewProtocol
extension SqlInjectionViewController: SqlInjectionViewProtocol {
}
