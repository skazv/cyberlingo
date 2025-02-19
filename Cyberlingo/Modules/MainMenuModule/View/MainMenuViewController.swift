//
//  MainMenuViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//

import UIKit

protocol MainMenuViewDelegate {
        func openCell(number: Int)
}

class MainMenuViewController: UIViewController {
    let mainMenuView = MainMenuView()
    var presenter: MainMenuPresenterProtocol?
    
    override func loadView() {
        super.loadView()
        view = mainMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
        //presenter?.viewDidLoad()
//        NetworkManager.parseJSON(jsonString: NetworkManager.jsonString)
//        NetworkManager.fetchCourses { courses in
//            print("courses:")
//            print(courses?.count)
//        }
    }
    
}

//MARK: - Private methods
extension MainMenuViewController {
    private func setup() {
        let educationGesture = UITapGestureRecognizer(target: self, action: #selector(openEducation))
        mainMenuView.educationView.addGestureRecognizer(educationGesture)
        
        let certificateGesture = UITapGestureRecognizer(target: self, action: #selector(openCertificate))
        mainMenuView.certificateView.addGestureRecognizer(certificateGesture)
        
        let jobGesture = UITapGestureRecognizer(target: self, action: #selector(openJob))
        mainMenuView.jobView.addGestureRecognizer(jobGesture)
        
        let toolsGesture = UITapGestureRecognizer(target: self, action: #selector(openTools))
        mainMenuView.toolsView.addGestureRecognizer(toolsGesture)
    }
    
    @objc private func openEducation() {
        presenter?.openEducationBoard()
    }
    
    @objc private func openCertificate() {
        presenter?.openCertificateBoard()
    }
    
    @objc private func openJob() {
        let url = URL(string: "https://staff.am/en/jobs?key_word=cybersecurity")
        if let url {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func openTools() {
        presenter?.openToolsBoard()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.font = FontLib.fontWithSize(font: .unboundedSemiBold, size: 30)
        label.textColor = .label
        label.text = ConstantNames.appName
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.leftItemsSupplementBackButton = true

        let profileImage = UIImage(named: ConstantNames.navBar)?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: profileImage,
                                                            landscapeImagePhone: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(openProfile))
    }
    
    @objc private func openProfile() {
//        let vc = ProfileRouter.createProfileModul()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - MainMenuViewProtocol
extension MainMenuViewController: MainMenuViewProtocol {
}
