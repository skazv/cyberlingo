//
//  EncryptionViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 06.02.25.
//

import UIKit
import CryptoKit

class EncryptionViewController: UIViewController {
    let encryptionView = EncryptionView()
    var presenter: EncryptionPresenterProtocol?
    var lesson: LessonViewModel?
    var rot: Int = 0
    var key: [String] = ["ThisIsA256BitLongKeyForAESEncryption"]
    var count: Int = 0
    let progress = BoardProgressView(progressText: "A", progress: 0.5)
    let randomMax = 8
    
    override func loadView() {
        super.loadView()
        view = encryptionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationSetup()
    }
    
}

//MARK: - Private methods
extension EncryptionViewController {
    private func setup() {
        guard let lesson = lesson else { return }
        let keyWord = key.randomElement()
        switch lesson.lessonType {
        case .ceaserEncryption:
            rot = Int.random(in: 1...randomMax)
            encryptionView.subjectLabel.text = LocalisationManager.decodetheText
            encryptionView.alphabetLabel.text = "\(lesson.contentLesson[count].translate)"
            encryptionView.rotLabel.text = "ROT\(rot)"
            encryptionView.encryptedLabel.text = caesarCipher(text: lesson.contentLesson[count].name, shift: rot)
            encryptionView.checkButton.addTarget(self, action: #selector(checkDecryption), for: .touchUpInside)
        case .symmetricEncryption:
            encryptionView.subjectLabel.text = LocalisationManager.decodetheText
            encryptionView.alphabetLabel.text = "\(lesson.contentLesson[count].translate)"
            encryptionView.rotLabel.text = keyWord//key.randomElement()//"ROT\(rot)"
            encryptionView.encryptedLabel.text = encryptAES(LocalisationManager.decodetheText, key: keyWord ?? "ThisIsA256BitLongKeyForAESEncryption")
            encryptionView.checkButton.addTarget(self, action: #selector(checkDecryption), for: .touchUpInside)
        default:
            rot = Int.random(in: 1...randomMax)
            encryptionView.subjectLabel.text = LocalisationManager.decodetheText
            encryptionView.alphabetLabel.text = "\(lesson.contentLesson[count].translate)"
            encryptionView.rotLabel.text = "ROT\(rot)"
            encryptionView.encryptedLabel.text = caesarCipher(text: lesson.contentLesson[count].name, shift: rot)
            encryptionView.checkButton.addTarget(self, action: #selector(checkDecryption), for: .touchUpInside)
        }
    }
    
    private func navigationSetup() {
        let backIcon = UIImage(named: ConstantNames.backButton)?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backIcon, style: .done, target: self, action: #selector(back))
        
        progress.layer.cornerRadius = 15
        progress.progressLabel.textColor = .label
        progress.progressView.progressTintColor = UIColor().hexStringToUIColor(hex: "72CC00")
        progress.clipsToBounds = true
        refresh()
        NSLayoutConstraint.activate([
            progress.heightAnchor.constraint(equalToConstant: 40),
            progress.widthAnchor.constraint(equalToConstant: 250)
        ])
        progress.backgroundColor = UIColor().hexStringToUIColor(hex: "EEEEEE")
        navigationItem.titleView = progress
        
    }
    
    private func refresh() {
        let totalCount = lesson?.contentLesson.count ?? 10
        let progressValue = Float(count) / Float(totalCount)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.progress.progressView.setProgress(progressValue, animated: true)
        }
        progress.update(progress: self.count, progressCount: self.lesson?.contentLesson.count ?? 10)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @objc func checkDecryption() {
        guard let lesson = lesson else { return }

        guard let inputText = encryptionView.inputTextView.text, !inputText.isEmpty else {
            encryptionView.resultLabel.text = "Введите текст!"
            encryptionView.resultLabel.textColor = .red
            shakeView(encryptionView.cardView)
            paintView(isCorrect: false)
            return
        }
        
        guard let encryptedText = encryptionView.encryptedLabel.text, !encryptedText.isEmpty else {
            encryptionView.resultLabel.text = "Ошибка в зашифрованном тексте!"
            encryptionView.resultLabel.textColor = .red
            shakeView(encryptionView.cardView)
            paintView(isCorrect: false)
            return
        }
        
        
        let decryptedText = caesarCipher(text: encryptedText, shift: rot, encrypt: false) // Дешифруем
        
        if inputText.lowercased() == decryptedText.lowercased() {
            //encryptionView.stackView.trans
            if (count + 1 < lesson.contentLesson.count)
            {
                UIView.transition(with: encryptionView.cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                encryptionView.inputTextView.text = ""
                rot = Int.random(in: 1...randomMax)
                count += 1
                //encryptionView.alphabetLabel.text = "\(lesson.words[count].translate)\n\(lesson.words[count].transcription)"
                encryptionView.alphabetLabel.text = "\(lesson.contentLesson[count].translate)"
                encryptionView.rotLabel.text = "ROT\(rot)"
                encryptionView.encryptedLabel.text = caesarCipher(text: lesson.contentLesson[count].name, shift: rot)
                encryptionView.resultLabel.text = "Верно!"
                encryptionView.resultLabel.textColor = .green
            } else {
                paintView(isCorrect: true)
                showConfetti()
                presenter?.openFinish()
            }
            
        } else {
            encryptionView.resultLabel.text = "Неверно, попробуйте ещё раз."
            encryptionView.resultLabel.textColor = .red
            self.shakeView(encryptionView.cardView)
            paintView(isCorrect: false)
        }
        refresh()
    }
    
    func paintView(isCorrect: Bool) {
        if (isCorrect == true) {
            UIView.animate(withDuration: 0.3, animations: {
                self.encryptionView.cardView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.encryptionView.cardView.backgroundColor = .secondarySystemBackground//.white
                }
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.encryptionView.cardView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.encryptionView.cardView.backgroundColor = .secondarySystemBackground//.white
                }
            }
        }
    }
    
    
    func caesarCipher(text: String, shift: Int, encrypt: Bool = true) -> String {
        let upperAlphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let lowerAlphabet = Array("abcdefghijklmnopqrstuvwxyz")
        
        let upperShiftedAlphabet = upperAlphabet.dropFirst(shift % upperAlphabet.count) + upperAlphabet.prefix(shift % upperAlphabet.count)
        let lowerShiftedAlphabet = lowerAlphabet.dropFirst(shift % lowerAlphabet.count) + lowerAlphabet.prefix(shift % lowerAlphabet.count)
        
        let upperMapping = Dictionary(uniqueKeysWithValues: zip(upperAlphabet, upperShiftedAlphabet))
        let lowerMapping = Dictionary(uniqueKeysWithValues: zip(lowerAlphabet, lowerShiftedAlphabet))
        
        if !encrypt {
            return caesarCipher(text: text, shift: upperAlphabet.count - (shift % upperAlphabet.count), encrypt: true)
        }
        
        let answer = text.map { character -> String in
            if let mappedCharacter = upperMapping[character] {
                return String(mappedCharacter)
            } else if let mappedCharacter = lowerMapping[character] {
                return String(mappedCharacter)
            } else {
                return String(character)
            }
        }.joined()
        
        return answer
    }
 
    func encryptAES(_ message: String, key: String) -> String {
        let keyNumbers = key.map { Int($0.asciiValue ?? 0) % 26 }
        var encryptedMessage = ""
        
        for (index, char) in message.enumerated() {
            if let ascii = char.asciiValue, char.isLetter {
                let shift = keyNumbers[index % keyNumbers.count]
                let base: UInt8 = char.isUppercase ? 65 : 97
                let newChar = Character(UnicodeScalar((Int(ascii) - Int(base) + shift) % 26 + Int(base))!)
                encryptedMessage.append(newChar)
            } else {
                encryptedMessage.append(char)
            }
        }
        return encryptedMessage
    }
    
    func decryptAES(text: String, key: String) -> String? {
        guard let data = Data(base64Encoded: text), let keyData = key.data(using: .utf8) else { return nil }
        
        let symmetricKey = SymmetricKey(data: keyData)
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
    
}


//MARK: - EncryptionViewProtocol
extension EncryptionViewController: EncryptionViewProtocol {
}
