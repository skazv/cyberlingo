//
//  ImageCheckViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 19.02.25.
//

import UIKit

class ImageCheckViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageView = UIImageView()
    let selectImageButton = UIButton(type: .system)
    let checkAIButton = UIButton(type: .system)
    let resultLabel = UILabel()
    
    let apiUser = ConstantNames.apiUser
    let apiSecret = ConstantNames.apiSecret
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        title = "AI image detector"
    }
    
    func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        selectImageButton.setTitle(LocalisationManager.selectImage, for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectImageButton)
        
        checkAIButton.setTitle(LocalisationManager.check, for: .normal)
        checkAIButton.isEnabled = false
        checkAIButton.addTarget(self, action: #selector(checkAIImage), for: .touchUpInside)
        checkAIButton.translatesAutoresizingMaskIntoConstraints = false
        checkAIButton.layer.cornerRadius = 20
        checkAIButton.backgroundColor = UIColor().hexStringToUIColor(hex: "9E4AE3")
        checkAIButton.setTitleColor(.white, for: .normal)
        view.addSubview(checkAIButton)
        
        resultLabel.textAlignment = .center
        resultLabel.textColor = .darkGray
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            selectImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            selectImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            checkAIButton.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 15),
            checkAIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkAIButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            checkAIButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            
            resultLabel.topAnchor.constraint(equalTo: checkAIButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
        resultLabel.text = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            checkAIButton.isEnabled = true
        }
        picker.dismiss(animated: true)
    }

    @objc func checkAIImage() {
        guard let image = imageView.image else {
            resultLabel.text = LocalisationManager.selectImage
            return
        }
        
        uploadImage(image: image)
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.9) else { return }
        
        let url = URL(string: "https://api.sightengine.com/1.0/check.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        let params: [String: String] = [
            "api_user": apiUser,
            "api_secret": apiSecret,
            "models": "genai"
        ]
        
        for (key, value) in params {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        let filename = "image.jpg"
        let mimetype = "image/jpeg"
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"media\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Ошибка сети"
                }
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Ответ API:", json)
                    DispatchQueue.main.async {
                        self.handleResponse(json: json)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Ошибка обработки ответа"
                }
            }
        }
        
        task.resume()
    }
  
    func handleResponse(json: [String: Any]) {
        print("Обрабатываем JSON:", json)

        guard let status = json["status"] as? String, status == "success",
              let type = json["type"] as? [String: Any],
              let aiGeneratedValue = type["ai_generated"] else {
            resultLabel.text = "Ошибка анализа"
            return
        }

        var aiGenerated: Double?

        if let aiGeneratedStr = aiGeneratedValue as? String {
            aiGenerated = Double(aiGeneratedStr.replacingOccurrences(of: ",", with: "."))
        } else if let aiGeneratedNum = aiGeneratedValue as? NSNumber {
            aiGenerated = aiGeneratedNum.doubleValue
        }

        guard let probability = aiGenerated else {
            resultLabel.text = "Ошибка обработки вероятности"
            return
        }

        let probabilityPercentage = probability * 100
        if probability > 0.5 {
            resultLabel.text = "AI-generated (probability: \(String(format: "%.2f", probabilityPercentage))%)"
        } else {
            resultLabel.text = "Real (probability: \(String(format: "%.2f", 100 - probabilityPercentage))%)"
        }
    }


}
