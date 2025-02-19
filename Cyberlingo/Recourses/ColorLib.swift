//
//  ColorLib.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import Foundation
import UIKit

enum ColorLib: String, CaseIterable {
    case iBubenBackground = "iBubenBackground"
    case iBubenSecondaryBackground = "iBubenSecondaryBackground"
    case iBubenSecondaryTop = "iBubenSecondaryTop"
    
    case realYellow = "RealYellow"
    case realBlue = "RealBlue"
    case realBrown = "RealBrown"
    case realLil = "RealLil"
    case realLowLil = "RealLowLil"
    case realMidLil = "RealMidLil"
    case realGreen = "RealGreen"
    case realDarkBlue = "RealDarkBlue"
    case realFiolet = "RealFiolet"
    case realGray = "RealGray"
    case realOrange = "RealOrange"
    
    var color: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
    
}
