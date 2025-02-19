//
//  ImageLib.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//



import Foundation
import UIKit

enum ImageLib: String, CaseIterable {
    case icon = "iBLogo"
    case alpabetIcon = "alphabetIcon"
    case storyIcon = "storyIcon"
    case guessIcon = "gIcon"
    case wordsIcon = "wordsIcon"
    case logo = "AppIcon"
    case armALetter = "armAletter"
    case achievement1 = "Achievement1"
    case achievement2 = "Achievement2"
    case achievement3 = "Achievement3"
    case achievement4 = "Achievement4"
    case achievement5 = "Achievement5"
    case achievement6 = "Achievement6"
    case achievement7 = "Achievement7"
    case achievement8 = "Achievement8"
    case achievement9 = "Achievement9"
    case achievement10 = "Achievement10"
    case encrypting = "encrypting"
    case phishing = "phishing"
    case password = "password"
    case sqlIjection = "sqlIjection"
    case artInt = "artInt"
    case image3d = "image3d"
    case voice3d = "voice3d"
    
    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
    
}

enum BlendLib: String, CaseIterable {
    case screen = "screenBlendMode"
    case additionCompositing = "additionCompositing"
    case colorBlendMode = "colorBlendMode"
    case colorBurnBlendMode = "colorBurnBlendMode"
    case colorDodgeBlendMode = "colorDodgeBlendMode"
    case darkenBlendMode = "darkenBlendMode"
    case differenceBlendMode = "differenceBlendMode"
    case divideBlendMode = "divideBlendMode"
    case exclusionBlendMode = "exclusionBlendMode"
    case hardLightBlendMode = "hardLightBlendMode"
    case hueBlendMode = "hueBlendMode"
    case lightenBlendMode = "lightenBlendMode"
    case linearBurnBlendMode = "linearBurnBlendMode"
    case linearDodgeBlendMode = "linearDodgeBlendMode"
    case luminosityBlendMode = "luminosityBlendMode"
    case maximumCompositing = "maximumCompositing"
    case minimumCompositing = "minimumCompositing"
    case multiplyBlendMode = "multiplyBlendMode"
    case multiplyCompositing = "multiplyCompositing"
    case overlayBlendMode = "overlayBlendMode"
}
