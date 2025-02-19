//
//  ToolsView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import UIKit

class ToolsView: UIView {
    var courseCollection = ToolsCollection()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension ToolsView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubviews(views: [
            courseCollection,
        ])
        
        NSLayoutConstraint.activate([
            courseCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            courseCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            courseCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            courseCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
    }
}
