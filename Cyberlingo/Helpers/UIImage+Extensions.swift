//
//  UIImage+Extensions.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//

import UIKit

public func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    let rect = CGRect(origin: .zero, size: newSize)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}

extension UIImage {
    class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        return UIImage.animatedImage(with: images, duration: 0.0)
    }
    
    func gifImageWithName(name: String) -> UIImage {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("Failed to find the GIF image.")
            return .actions
        }

        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return .actions
        }

        guard let gifImage = UIImage.gifImageWithData(gifData) else {
            print("Failed to create the GIF image.")
            return .actions
        }
        return gifImage
    }
}

extension UIImage {

    class func gifImageWithData(_ data: Data, with duration: TimeInterval) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []

        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }

        return UIImage.animatedImage(with: images, duration: duration)
    }

    func gifImageWithName(name: String, duration: TimeInterval) -> UIImage {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("Failed to find the GIF image.")
            return .actions
        }

        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return .actions
        }

        guard let gifImage = UIImage.gifImageWithData(gifData, with: duration) else {
            print("Failed to create the GIF image.")
            return .actions
        }
        return gifImage
    }

}

func emojiToImage(emoji: String, size: CGFloat) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
    return renderer.image { _ in
        (emoji as NSString).draw(in: CGRect(x: 0, y: 0, width: size, height: size),
                                 withAttributes: [.font: UIFont.systemFont(ofSize: size)])
    }
}
