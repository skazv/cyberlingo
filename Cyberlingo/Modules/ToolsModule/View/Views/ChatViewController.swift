//
//  ChatViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 17.02.25.
//


import UIKit
import NotificationCenter

struct Message {
    let text: String
    let isUser: Bool
}

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var stackViewBottomConstraint: NSLayoutConstraint!
    private let apiKey = ConstantNames.apiOpenAI
    
    private var messages: [Message] = []
    private let lessonCourses = "We have lessons: AI or Not, Password, Phishing, Cryptography, SQL Injection"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: "ChatCell")
        return collectionView
    }()

    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a question..."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
     private func setupKeyboard() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
        @objc private func handleKeyboardNotification(notification: Notification) {
            guard let userInfo = notification.userInfo else { return }
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let keyboardHeight = isKeyboardShowing ? keyboardFrame.height : 0
    
            stackViewBottomConstraint.constant = -keyboardHeight
    
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [textField, sendButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        let inputContainer = UIView()
        stackViewBottomConstraint = stackView.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: -10)
        inputContainer.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: inputContainer.topAnchor, constant: 10),
            stackViewBottomConstraint,
            stackView.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(collectionView)
        view.addSubview(inputContainer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor),
            
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func sendMessage() {
        guard let userInput = textField.text, !userInput.isEmpty else { return }
        messages.append(Message(text: userInput, isUser: true))
        textField.text = ""
        collectionView.reloadData()
        
        let prompt = "You're a cybersecurity expert. \(lessonCourses) The answer to the question: \(userInput). Answer with not more than 5 words"
        fetchChatGPTResponse(prompt: prompt) { [weak self] response in
            DispatchQueue.main.async {
                if let response = response {
                    self?.messages.append(Message(text: response, isUser: false))
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func fetchChatGPTResponse(prompt: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": [["role": "user", "content": prompt]],
            "max_tokens": 50
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                completion(content)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.item]
        cell.configure(with: message)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.item]
        return CGSize(width: 300, height: 2000)
    }
}

class ChatCell: UICollectionViewCell {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = .clear
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.text
        
        if message.isUser {
            contentView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
        } else {
            contentView.backgroundColor = .lightGray
            messageLabel.textColor = .black
        }
    }
}

// MARK: - Extensions
extension UITextField {
    func paddingLeft(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
