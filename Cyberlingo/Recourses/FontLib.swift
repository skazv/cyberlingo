//
//  FontLib.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import UIKit

enum FontLib: String, CaseIterable {
    case unboundedRegular = "Unbounded-Regular"
    case unboundedExtraLight = "Unbounded-Regular_ExtraLight"
    case unboundedLight = "Unbounded-Regular_Light"
    case unboundedMedium = "Unbounded-Regular_Medium"
    case unboundedSemiBold = "Unbounded-Regular_SemiBold"
    case unboundedBold = "Unbounded-Regular_Bold"
    case unboundedExtraBold = "Unbounded-Regular_ExtraBold"
    case unboundedBlack = "Unbounded-Regular_Black"
    
    var font: UIFont {
        return UIFont(name: self.rawValue, size: 50) ?? .boldSystemFont(ofSize: 12)
    }
    
    static func fontWithSize(font: FontLib, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? .boldSystemFont(ofSize: 12)
    }
    
}
