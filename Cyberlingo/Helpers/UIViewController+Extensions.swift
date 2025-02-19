//
//  UIViewController+Extensions.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func showAlarm(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func shakeView(_ view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.values = [-10, 10, -8, 8, -6, 6, -4, 4, 0]
        animation.duration = 0.4
        view.layer.add(animation, forKey: "shake")
    }
    
    func showConfetti() {
        showConfetti1()
        showConfetti2()
    }
    func showConfetti1() {
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 5.0
        cell.velocity = CGFloat.random(in: 100...200)
        cell.velocityRange = 50
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spin = CGFloat.random(in: 1...3)
        cell.spinRange = 1
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.contents = emojiToImage(emoji: "🎉", size: 50)?.cgImage
        
        confettiLayer.emitterCells = [cell]
        view.layer.addSublayer(confettiLayer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            confettiLayer.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                confettiLayer.removeFromSuperlayer()
            }
        }
    }

    
    func showConfetti2() {
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: view.bounds.size.width, height: 1)
        let colors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple]
        let cells: [CAEmitterCell] = colors.map { color in
            let cell = CAEmitterCell()
            cell.birthRate = 5
            cell.lifetime = 5.0
            cell.velocity = CGFloat.random(in: 100...200)
            cell.velocityRange = 50
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spin = CGFloat.random(in: 1...3)
            cell.spinRange = 1
            cell.scale = 0.05
            cell.scaleRange = 0.02
            cell.contents = emojiToImage(emoji: "🎉", size: 30)?.cgImage
            cell.color = color.cgColor
            return cell
        }
        confettiLayer.emitterCells = cells
        view.layer.addSublayer(confettiLayer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            confettiLayer.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                confettiLayer.removeFromSuperlayer()
            }
        }
    }
    
}
