//
//  UIView+Extensions.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.systemGray2.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
      }
    
}
