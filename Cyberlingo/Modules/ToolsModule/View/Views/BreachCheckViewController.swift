//
//  BreachCheckViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 19.02.25.
//

import UIKit

class BreachCheckViewController: UIViewController {
    
    let emailTextField = UITextField()
    let checkButton = UIButton(type: .system)
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        title = "Checking for leaks"
    }
    
    func setupUI() {
        emailTextField.placeholder = "Please enter your email address"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        checkButton.setTitle(LocalisationManager.check, for: .normal)
        checkButton.addTarget(self, action: #selector(checkBreach), for: .touchUpInside)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.layer.cornerRadius = 20
        checkButton.backgroundColor = UIColor().hexStringToUIColor(hex: "9E4AE3")
        checkButton.setTitleColor(.white, for: .normal)
        view.addSubview(checkButton)
        
        resultLabel.textAlignment = .center
        resultLabel.textColor = .darkGray
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            
            checkButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            checkButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            
            resultLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func checkBreach() {
        guard let email = emailTextField.text, !email.isEmpty else {
            resultLabel.text = "Please enter your email address"
            return
        }
        
        checkEmailBreach(email: email)
    }
    
    func checkEmailBreach(email: String) {
        let url = URL(string: "https://breachdirectory.p.rapidapi.com/breach/\(email)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(ConstantNames.apiBreach, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("breachdirectory.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        self.handleResponse(json: jsonResponse)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Error обработки ответа"
                }
            }
        }
        
        task.resume()
    }
    
    func handleResponse(json: [String: Any]) {
        if let breaches = json["breaches"] as? [[String: Any]], breaches.count > 0 {
            resultLabel.text = "Leaks found!"
        } else {
            resultLabel.text = "No leaks found."
        }
    }
}
