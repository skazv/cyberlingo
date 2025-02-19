//
//  SwipeQuizViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit
import AVFoundation

class SwipeQuizViewController: UIViewController {
    let swipeQuizView = SwipeQuizView()
    var presenter: SwipeQuizPresenterProtocol?
    var currentCardNumber = 1
    var lesson: LessonViewModel?
    var isSwipped: Bool = true
//    var examViewModel: ExamViewModel?
    var grade: Int = 0
    var wrongAnswers = 0
    var audioPlayer: AVAudioPlayer?
    
    override func loadView() {
        super.loadView()
        view = swipeQuizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItems()
    }
    
}

//MARK: - Private methods
extension SwipeQuizViewController {
    
    private func setup() {
        guard let lesson = lesson else { return }
        if lesson.isExamPassed == true {
            swipeQuizView.leftButton.setTitle("AI", for: .normal)
            swipeQuizView.rightButton.setTitle("Not AI", for: .normal)
        } else {
            swipeQuizView.leftButton.setTitle("Phishing", for: .normal)
            swipeQuizView.rightButton.setTitle("Not Phishing", for: .normal)
        }
        self.lesson?.contentLesson.shuffle()
        swipeQuizView.cardStack.delegate = self
        swipeQuizView.cardStack.dataSource = self
        swipeQuizView.updateView(name: LocalisationManager.cardHint)
//        if let lesson = lesson {
//            changeAnwers(words: lesson.words, index: 0)
//        }
        swipeQuizView.leftButton.addTarget(self, action: #selector(leftTapped), for: .touchUpInside)
        swipeQuizView.rightButton.addTarget(self, action: #selector(rightTapped), for: .touchUpInside)
    }
    
    private func setupNavigationItems() {
        guard let cardsCount = lesson?.contentLesson.count else { return }
        title = "\(currentCardNumber) / \(cardsCount)"
        
        navigationController?.navigationBar.tintColor = UIColor().hexStringToUIColor(hex: "466CFF")//.systemOrange
//        let closeImage = UIImage(systemName: "xmark")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
    }
    
    @objc private func closeTapped() {
        presenter?.closeView()
    }

    @objc func leftTapped() {
        swipeQuizView.cardStack.swipe(.left, animated: true)
    }
    
    @objc func rightTapped() {
        swipeQuizView.cardStack.swipe(.right, animated: true)
    }
        
    private func checkAnswer(name: String, side: String) -> Bool {
        var isCorrect = false
        if name == side {
            isCorrect = true
        }
        return isCorrect
    }
    
//    private func changeAnwers(words: [WordViewModel], index: Int) {
//        let wordsArr = randomWords(mainWord: words[index].translate, words: words)
//        if wordsArr.isEmpty == false {
//            swipeQuizView.updateAnswers(top: wordsArr[0],
//                                     right: verticalTextConverter(text: wordsArr[1]),
//                                     bot: wordsArr[2],
//                                     left: verticalTextConverter(text: wordsArr[3]))
//        }
//    }
    
    private func startExam() {
//        guard let isExamPass = isExamPass else { return }
        guard let isExamPassed = lesson?.isExamPassed else { return }
        let okAction = UIAlertAction(title: LocalisationManager.start, style: UIAlertAction.Style.default) {
            UIAlertAction in
            if let shuffledWords = self.lesson?.contentLesson.shuffled() {
//                self.presenter?.openLessonExam(words: shuffledWords, isExamPass: isExamPassed)
            }
        }
//        showActionAlarm(navigation: self, title: "", message: LocalisationManager.examStart, action: okAction)
    }
    
    private func answerCheck(isCorrect: Bool) {
        if isCorrect {
            grade += 1
            swipeQuizView.updateView(name: "\(LocalisationManager.correctCard) \(grade) \(LocalisationManager.wrongAnser) \(wrongAnswers)")
            swipeQuizView.nameLabel.textColor = .systemGreen
        } else {
            wrongAnswers += 1
            swipeQuizView.updateView(name: "\(LocalisationManager.wrongCard) \(grade) \(LocalisationManager.wrongAnser) \(wrongAnswers)")
            swipeQuizView.nameLabel.textColor = .systemRed
        }
    }
    
}


//MARK: - SwipeQuizViewProtocol
extension SwipeQuizViewController: SwipeQuizViewProtocol {
}

//MARK: - SwipeCardStackDelegate
extension SwipeQuizViewController: SwipeCardStackDelegate {

    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        UIView.transition(with: swipeQuizView.cardStack, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            let x = cardStack.card(forIndexAt: index) as? CardView
            x?.flip(word: lesson?.contentLesson[index].name ?? "", translation: lesson?.contentLesson[index].translate ?? "")
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        guard let words = lesson?.contentLesson else { return }
        if isSwipped == true && currentCardNumber + 1 <= words.count {
            currentCardNumber += 1
            title = "\(currentCardNumber) / \(words.count)"
        }
        let name = words[index].name
        switch direction {
        case .left:
//            let name = verticalTextConverter(text: words[index].name)
            answerCheck(isCorrect: checkAnswer(name: name, side: "false"))
        case .right:
//            let name = verticalTextConverter(text: words[index].name)
            answerCheck(isCorrect: checkAnswer(name: name, side: "true"))
//        case .up:
//            let name = words[index].translate
//            answerCheck(isCorrect: checkAnswer(name: name, side: "false"))
//        case .down:
//            let name = words[index].translate
//            answerCheck(isCorrect: checkAnswer(name: name, side: "false"))
        default:
            print("cardStack swipe error")
        }
        
        if cardStack.topCardIndex == nil {
            //MARK: -New-
            guard let lesson = self.lesson else { return }
            self.showConfetti()
            presenter?.openFinish()
//            Purchases.shared.getCustomerInfo { (costumer, error) in
//                if costumer?.entitlements[Constants.entitlemetID]?.isActive == true {
//                    self.startExam()
//                } else {
//                    if UserDefaultsManager.checkTime(userDefaultsKeys: .timerLessonExam) == true || lesson.isExamPassed == true {
//                        self.startExam()
//                    } else {
//                        self.lessonView.nameLabel.textColor = .systemGray
//                        self.lessonView.updateView(name: "Повторите слова еще раз, чтобы лучше подготовиться к экзамену!")
//                        self.lessonView.hideAnswers()
//                        self.showPaywall()
//                    }
//                }
//            }
            //MARK: -New-
        } else {
//            changeAnwers(words: words, index: index + 1)
        }
        
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
//        print(index)
    }
}

//MARK: - SwipeCardStackDataSource
extension SwipeQuizViewController: SwipeCardStackDataSource {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        guard let words = lesson?.contentLesson else { return SwipeCard() }
        return card(word: words[index].name, imageName: words[index].image, translation: words[index].translate, transcription: words[index].transcription, type: lesson?.lessonType ?? .quiz)
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return lesson?.contentLesson.count ?? 0
    }
    
    func card(word: String, imageName: String, translation: String, transcription: String?, type: LessonType) -> SwipeCard {
        let card = CardView(name: word, imageName: imageName, transcription: transcription, type: type)//SwipeCard()
        card.cardCellDelegate = self
//        card.swipeDirections = [.left, .right, .up, .down]
        card.swipeDirections = [.left, .right]
        
        let leftOverlay = UIView()
        leftOverlay.layer.cornerRadius = 25
        leftOverlay.backgroundColor = .red//ColorLib.realLil.color
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = .green//ColorLib.realGreen.color
        rightOverlay.layer.cornerRadius = 25
        
        let upOverlay = UIView()
        upOverlay.backgroundColor = .white//ColorLib.realBlue.color
        upOverlay.layer.cornerRadius = 25
        
        let downOverlay = UIView()
        downOverlay.backgroundColor = .white//ColorLib.realYellow.color
        downOverlay.layer.cornerRadius = 25
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay, .up: upOverlay, .down: downOverlay])
        
        return card
    }
    
}

//MARK: - SwipeCardStackDataSource
extension SwipeQuizViewController: CardCellDelegate {
//    func soundTappd(cell: SwipeCard) {
////        showAlarm(navigation: self, title: "Сообщение", message: Constants.soundInProgressText)
//        if let player = audioPlayer, player.isPlaying {
//            player.stop()
//        } else {
////            guard let letterVM = letterVM else { return }
////            guard let lesson = lesson else { return }
//            guard let words = lesson?.words else { return }
//            let source = Bundle.main.path(forResource: words[currentCardNumber - 1].sound, ofType: "mp3")
//
//            if let source = source {
//                let url = URL(fileURLWithPath: source)
//                do {
//                    audioPlayer = try AVAudioPlayer(contentsOf: url)
//                    audioPlayer?.play()
//                } catch {
//                    print("error")
//                }
//            }
//        }
//
//    }
    
    func soundTappd(cell: SwipeCard) {
        guard let words = lesson?.contentLesson else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Ошибка при настройке аудиосессии: \(error)")
        }

        if let soundURL = Bundle.main.url(forResource: words[currentCardNumber - 1].sound, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Ошибка при воспроизведении аудиофайла: \(error)")
            }
        }
    }
    
    func giveIndexByCard(swipeCard: SwipeCard) -> Int {
        let count = 0
        guard let words = lesson?.contentLesson else { return 0 }
        for card in words {
            if swipeCard == swipeQuizView.cardStack.card(forIndexAt: card.id) {
                return card.id
            }
        }
        return count
    }
    
}
////MARK: - SwipeCardStackDataSource
//extension SwipeQuizViewController: TotalUserCardsDelegate {
//    func close() {
////        presenter?.router?.dismissUserCards(from: self, completion: nil)
//    }
    
//}
