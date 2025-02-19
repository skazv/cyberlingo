//
//  TotalUserCardsDelegate.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//


//import Foundation
//import UIKit
//
//protocol TotalUserCardsDelegate {
//    func close()
//}
//
//class TotalUserCardsViewController: UIViewController {
//    let totalUserCardsView = TotalUserCardsView()
//    var userCourseVM: UserCourseViewModel?
//    var userCardsArr: [UserCardViewModel] = []
//    var totalUserCardsDelegate: TotalUserCardsDelegate?
//    var rememberCount: Int = 0
//    
//    override func loadView() {
//        super.loadView()
//        view = totalUserCardsView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationItems()
//        setup()
//    }
//    
//    init(userCourseVM: UserCourseViewModel?, userCardsArr: [UserCardViewModel], rememberCount: Int, delegate: TotalUserCardsDelegate) {
//        super.init(nibName: nil, bundle: nil)
//        self.userCourseVM = userCourseVM
//        self.userCardsArr = userCardsArr
//        self.rememberCount = rememberCount
//        self.totalUserCardsDelegate = delegate
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
////MARK: - Private methods
//extension TotalUserCardsViewController {
//    private func setup() {
//        guard let userCourseVM = userCourseVM else { return }
//        guard let userCards = userCourseVM.cards else { return }
//        userCardsArr = userCards
//        let persent: Int = Int((Double(rememberCount) / Double(userCardsArr.count)) * 100)
//        totalUserCardsView.totalCountLabel.text = "\(LocalisationManager.totalCards): \(userCardsArr.count)"
//        totalUserCardsView.rememberCountLabel.text = "\(LocalisationManager.remembered): \(rememberCount)"
//        totalUserCardsView.percentCountLabel.text = "\(LocalisationManager.percent): \(persent)%"
//        totalUserCardsView.okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
//    }
//    
//    private func setupNavigationItems() {
////        title = "Итоги"
////
////
////        navigationController?.navigationBar.tintColor = .systemOrange
////        let closeImage = UIImage(systemName: "xmark")
////        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
//        
//    }
//    
//    @objc func okTapped() {
////        navigationController?.popViewController(animated: true)
////        totalUserCardsDelegate?.close()
////        self.dismiss(animated: true)
//        self.dismiss(animated: false) {
//            print("complition")
//            self.totalUserCardsDelegate?.close()
//        }
//        print("moreTapped")
//    }
//    
//}
