//
//  FinishModuleViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 16.02.25.
//

import UIKit

class FinishModuleViewController: UIViewController {
    let finishModuleView = FinishModuleView()
    var presenter: FinishModulePresenterProtocol?
    
    override func loadView() {
        super.loadView()
        view = finishModuleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension FinishModuleViewController {
    private func setup() {
        finishModuleView.actionButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    }
    
    @objc func closeView() {
        presenter?.closeView()
    }
}


//MARK: - FinishModuleViewProtocol
extension FinishModuleViewController: FinishModuleViewProtocol {
}
