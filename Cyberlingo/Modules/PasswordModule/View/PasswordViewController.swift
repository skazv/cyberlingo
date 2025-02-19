//
//  PasswordViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 13.02.25.
//

import UIKit

class PasswordViewController: UIViewController {
    let passwordView = PasswordView()
    var presenter: PasswordPresenterProtocol?
    var lesson: LessonViewModel?
    var count: Int = 0
    
    override func loadView() {
        super.loadView()
        view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension PasswordViewController {
    private func setup() {
      //  title = "Brute force simulation"
        guard let lesson = lesson else { return }
        passwordView.titleLabel.text = lesson.contentLesson[count].name
        passwordView.infoLabel.text = lesson.contentLesson[count].description
        passwordView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        passwordView.stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        guard let lesson = lesson else { return }
        passwordView.titleLabel.text = lesson.contentLesson[count].name
        passwordView.infoLabel.text = lesson.contentLesson[count].description
        if (count == 0) {
            startButtonTapped1()
        }
        else {
            startButtonTapped2()
        }
    }
    @objc func startButtonTapped1() {
        guard let password = passwordView.passwordTextField.text, !password.isEmpty else {
            passwordView.consoleView.text.append(">> Enter a password to start dictionary attack.\n")
            passwordView.consoleView.scrollRangeToVisible(NSRange(location: passwordView.consoleView.text.count - 1, length: 1))
            return
        }

        let dictionary = [
            "123456", "password", "123456789", "12345", "12345678", "qwerty", "abc123", "password1", "123123", "1q2w3e4r",
            "iloveyou", "sunshine", "qwerty123", "admin", "letmein", "1234", "welcome", "monkey", "123", "123321",
            "qwertyuiop", "superman", "dragon", "abc123456", "111111", "123qwe", "password123", "1qaz2wsx", "trustno1",
            "football", "123qwerty", "qazwsx", "123abc", "letmein123", "1qazxsw2", "qwertyuiop1", "iloveyou1", "password1",
            "qwerty1234", "1qaz2wsx3e4r", "qwerty1", "hello", "welcome123", "1234qwert", "12345qwerty", "123qwert",
            "sunshine1", "password01", "11111111", "qwerty12345", "hello123", "password1234", "123abc456", "123123qwerty",
            "letmein1", "qwertyuiopasdfghjkl", "123pass", "123qwerty123", "dragon123", "1qazxsw2cde3vfr4", "admin123",
            "1234abcd", "qwertyqwerty", "qazwsx123", "qwerty@123", "1q2w3e4r5t6y7u", "qwerty12", "pass123", "qwert",
            "asdfghjkl", "welcome1", "qwerty12345", "555555", "superman123", "1234qwe", "qwerty12", "123abcd", "letmein1234",
            "ashley", "batman", "qwerty1!", "password01!", "qwertyqwerty123", "qwertyzx", "qwertytiger", "abcd1234",
            "123panda", "abcdef", "123qweasd", "qwerty12345!", "shadow", "password12345", "abcdef123", "football123",
            "trustno123", "dragon12345", "dragon12", "secret123", "monkey123", "1qaz2wsx3e", "12345qwert", "1q2w3e4r5t6y",
            "password123qwerty", "superman12", "12345abcd", "sunshine123", "qwertyzx123", "iloveyou123", "password777",
            "qwertyuiop12345", "1qazxsw2cde3", "123qwertyuiop", "letmein12345", "password1!", "welcome2", "jennifer",
            "1qazwsx2", "1234abcd12", "qwertyqwert", "hello1234", "monkey12345", "qwerty1234!", "123password", "iloveyou2",
            "trustno1234", "qwerty2013", "1234abcd1234", "dragonball", "jessica", "password12345!", "qwerty789", "root",
            "password12345qwerty", "1qazxsw2cde3vfr4tgb", "123qwerty1", "access", "lovely", "1234abc", "sunshine@123",
            "samsung", "abcdefg", "123123123", "p@ssw0rd", "loveyou", "qwerty1qwerty", "daniel", "123password1", "charlie",
            "freedom", "alex", "1234qwerty", "qwerty2014", "system", "computer", "qwert1234", "monkey1234", "asdf1234",
            "mypassword", "flower", "1qaz2wsxqwe", "adrian", "cristian", "sunshine12", "hunter", "fuckyou", "1234password",
            "superman1234", "mercedes", "richard", "ferrari", "iloveyou12345", "joker", "spongebob", "1234qwert1234",
            "password#1", "heather", "cheese", "qwerty12!", "123qwertyu", "platinum", "password@123", "john", "qwerty098",
            "12345password", "sweet", "1q2w3e4r5t6y7u8i9o0", "please", "adminadmin", "chelsea", "chicken", "joseph",
            "michael", "christmas", "trustinme", "brittany", "starwars", "starwars1", "matthew", "liverpool", "mypass123",
            "hello12345", "p@ssw0rd123", "alice", "darkknight", "lovely123", "1qaz2wsx3", "bigmoney", "qwerty14", "1q2w3e4r5",
            "carolina", "password!123", "tiger", "jordan", "hello12345!", "football1", "trustno1!", "twilight", "chocolate",
            "loveme", "jennifer123", "12345qwert", "1234567890", "admin1", "111111111", "123qwertyui", "password!123",
            "iloveyou1!", "12345admin", "hello1", "george", "coconut", "purple", "iloveyou!!", "qwerty7890", "michigan",
            "1qazxsw2cde3r", "bigdaddy", "admin1!", "mylove", "password1234!", "julia", "1231234", "iloveyou111", "123qwert",
            "starwars123", "governor", "password01!", "baller", "kevin", "matt", "universe", "alex123", "boston", "1qazwsx",
            "qwerty2015", "sunshine1!", "superhero", "sunshine12345", "1234sunshine", "secure123", "hunter123", "123qwertyuiop",
            "squirrel", "admin1234", "password123456", "qwertyzxcvbnm", "12345football", "123abcqwerty", "123abc123",
            "sunshine1234", "love123", "12345hello", "qwerty@1234", "yougotit", "lucky", "yankees", "stars", "abcqwert",
            "trustme", "iloveyou1234", "superwoman", "loveme123", "master", "cutie", "sakura", "iloveyou1!", "soccer", "team",
            "apple123", "dragon1", "alexis", "sunshine1!", "12345hello1", "starwars1!", "qwertyqwerty1", "superman12345",
            "winter", "12345love", "123qweasd1", "married", "adminadmin1", "rocket", "emily", "ashley123", "1234qwerty12",
            "iloveyouforever", "test123", "sunny", "mama", "qwerty12!!", "abcd123", "chocolate1", "swordfish", "cuteboy",
            "john123", "123abc1234", "king", "loveyou1234", "mylove123", "monkey12", "admin123!", "testpassword", "batman123",
            "12345money", "tiger123", "lion", "wizard", "youandme", "everett", "cheese123", "lovely1234", "loveyou1234",
            "qwerty1qwerty1", "adidas", "dragonballz", "maggie", "test1", "helloqwerty", "123qwerty1234", "baby123", "greatday"
        ]




        var isFound = false
        var attemptsCount = 0
        
        passwordView.isStopped = false
        passwordView.stopButton.isHidden = false
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            for word in dictionary {
                attemptsCount += 1

                if word == password {
                    isFound = true
                    DispatchQueue.main.async {
                        self.passwordView.consoleView.textColor = .red
                        self.passwordView.consoleView.text.append(">> Password found: \(word) after \(attemptsCount) attempts!\n")
                        self.passwordView.consoleView.scrollRangeToVisible(NSRange(location: self.passwordView.consoleView.text.count - 1, length: 1))
                    }
                    return
                }

                if attemptsCount % 1 == 0 {
                    DispatchQueue.main.async {
                        self.passwordView.consoleView.text.append("\(word)\n")
                        self.passwordView.consoleView.scrollRangeToVisible(NSRange(location: self.passwordView.consoleView.text.count - 1, length: 1))
                    }
                }

                if self.passwordView.isStopped {
                    DispatchQueue.main.async {
                        self.passwordView.consoleView.text.append(">> Brute force stopped.\n")
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                if !isFound {
                    self.passwordView.consoleView.textColor = .green
                    self.passwordView.consoleView.text.append(">> Password not found in dictionary.\n")
                    self.count = 1
                }
            }
            
        }
    }
    
    @objc func startButtonTapped2() {
        guard let password = passwordView.passwordTextField.text, !password.isEmpty else {
            passwordView.consoleView.text.append(">> Enter a password to start brute forcing.\n")
            passwordView.consoleView.scrollRangeToVisible(NSRange(location: passwordView.consoleView.text.count - 1, length: 1))
            return
        }
        
        let charset = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!.")
        let charsetCount = charset.count
        let threadCount = 4
        var isFound = false
        var attemptsCount = 0
        passwordView.isStopped = false
        passwordView.stopButton.isHidden = false
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        let lock = NSLock()
        let startTime = Date()
        let secondsNeed: TimeInterval  = self.estimateBForceTime(password: password)
        var bruteForceTimeLimit: TimeInterval = secondsNeed
        let minUpdateInterval: TimeInterval = 0.1
        var lastUpdateTime = Date()
        
        if secondsNeed > 10 {
            bruteForceTimeLimit = 10
        } else if secondsNeed < 1 {
            bruteForceTimeLimit = 1
        }

        queue.async {
            DispatchQueue.concurrentPerform(iterations: threadCount) { threadID in
                var attempt = String(charset[threadID])

                while !isFound && !self.passwordView.isStopped {
                    let attemptStr = attempt

                    lock.lock()
                    attemptsCount += 1
                    lock.unlock()

                    if attemptStr == password {
                        isFound = true
                        DispatchQueue.main.async {
                            let elapsedTime = Date().timeIntervalSince(startTime)
                            self.passwordView.consoleView.text.append(">> Password found: \(attemptStr) after \(attemptsCount) attempts in \(elapsedTime) sec!\n")
                            self.passwordView.consoleView.scrollRangeToVisible(NSRange(location: self.passwordView.consoleView.text.count - 1, length: 1))
                        }
                        return
                    }

                    let currentTime = Date()
                    if currentTime.timeIntervalSince(lastUpdateTime) >= minUpdateInterval {
                        lastUpdateTime = currentTime
                        DispatchQueue.main.async {
                            self.passwordView.consoleView.text.append("Attempt: \(attemptsCount) \(attemptStr)\n")
                            self.passwordView.consoleView.scrollRangeToVisible(NSRange(location: self.passwordView.consoleView.text.count - 1, length: 1))
                        }
                    }

                    if Date().timeIntervalSince(startTime) > bruteForceTimeLimit {
                        self.passwordView.isStopped = true
                        break
                    }

                    var attemptChars = Array(attempt)
                    var index = attemptChars.count - 1

                    while index >= 0 {
                        if let charIndex = charset.firstIndex(of: attemptChars[index]), charIndex < charsetCount - 1 {
                            attemptChars[index] = charset[charIndex + 1]
                            break
                        } else {
                            attemptChars[index] = charset.first!
                            index -= 1
                        }
                    }

                    if index < 0 {
                        attemptChars.insert(charset[threadID], at: 0)
                    }

                    attempt = String(attemptChars)
                }
            }

            DispatchQueue.main.async {
                if !isFound {
                    let (estimatedTime, isSafe) = self.estimateBruteForceTime(password: password)
                    if (isSafe == true) {
                        self.showConfetti()
                        self.passwordView.consoleView.textColor = .green
                        self.passwordView.consoleView.text.append(">> Estimated time to brute force: \(estimatedTime)\nPassword safe")
                        self.presenter?.openFinish()
                    } else {
                        self.passwordView.consoleView.textColor = .red
                        self.passwordView.consoleView.text.append(">> Estimated time to brute force: \(estimatedTime)\nPassword not safe")
                    }
                }
            }
        }
    }

    
    
    func estimateBForceTime(password: String, attemptsPerSecond: Double = 1_000_000_000, secureThreshold: Double = 315_360_000_000) -> Double {
        let charsetSize = calculateCharsetSize(password: password)
        let totalCombinations = pow(Double(charsetSize), Double(password.count))
        
        let seconds = totalCombinations / attemptsPerSecond
        return (seconds)
    }
    
    
    func estimateBruteForceTime(password: String, attemptsPerSecond: Double = 1_000_000_000, secureThreshold: Double = 315_360_000_000) -> (String, Bool) {
        var isSafe: Bool = false
        let charsetSize = calculateCharsetSize(password: password)
        let totalCombinations = pow(Double(charsetSize), Double(password.count))
        
        let seconds = totalCombinations / attemptsPerSecond
        if (seconds > secureThreshold) {
            isSafe = true
        }
        return (formatTime(seconds: seconds), isSafe)
    }

    func calculateCharsetSize(password: String) -> Int {
        var charsetSize = 0
        
        let lowercase = CharacterSet.lowercaseLetters
        let uppercase = CharacterSet.uppercaseLetters
        let digits = CharacterSet.decimalDigits
        let specialChars = CharacterSet.punctuationCharacters.union(.symbols)
        
        if password.rangeOfCharacter(from: lowercase) != nil { charsetSize += 26 }
        if password.rangeOfCharacter(from: uppercase) != nil { charsetSize += 26 }
        if password.rangeOfCharacter(from: digits) != nil { charsetSize += 10 }
        if password.rangeOfCharacter(from: specialChars) != nil { charsetSize += 32 }
        
        return max(charsetSize, 1)
    }

    func formatTime(seconds: Double) -> String {
        if seconds < 1 { return "Less than 1 second" }
        let timeUnits: [(Double, String)] = [
            (60, LocalisationManager.second), (60, LocalisationManager.minutes), (24, LocalisationManager.hours),
            (30, LocalisationManager.days), (12, LocalisationManager.months), (100, LocalisationManager.years),
            (1000, LocalisationManager.thousandYear), (1000, LocalisationManager.millionYears),
            (1000, LocalisationManager.billionYears)
        ]
        
        var value = seconds
        var unit = LocalisationManager.second
        
        for (divisor, unitName) in timeUnits {
            if value < divisor { break }
            value /= divisor
            unit = unitName
        }
        
        return String(format: "%.2f %@", value, unit)
    }

    
    @objc func stopButtonTapped() {
        passwordView.isStopped = true
        passwordView.stopButton.isHidden = true
        passwordView.consoleView.text.append(">> Brute force stopped.\n")
        passwordView.consoleView.scrollRangeToVisible(NSRange(location: passwordView.consoleView.text.count - 1, length: 1))
    }
}


//MARK: - PasswordViewProtocol
extension PasswordViewController: PasswordViewProtocol {
}
