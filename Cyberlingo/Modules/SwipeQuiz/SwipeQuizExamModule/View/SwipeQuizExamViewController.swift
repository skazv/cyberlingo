//
//  SwipeQuizExamViewController.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

import UIKit

class SwipeQuizExamViewController: UIViewController {
    let swipeQuizExamView = SwipeQuizExamView()
    var presenter: SwipeQuizExamPresenterProtocol?
    var words: [ContentLessonViewModel]?
    var currentCardNumber = 1
    var isSwipped: Bool = true
    var isTimeOut: Bool = true
    var examViewModel: ExamViewModel?
    var timer = Timer()
    var time = 120 {
        didSet {
            swipeQuizExamView.timerLabel.text =  "\(time/60):\(time%60)"
            //payWallView.timerLabel.text =  "\(time)"
        }
    }
    
    override func loadView() {
        super.loadView()
        view = swipeQuizExamView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationItems()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(examTimer),
                                     userInfo: nil,
                                     repeats: true)
        setupExamVM()
    }
    
    @objc private func examTimer() {
        time -= 1
        if time == 0 {
            timer.invalidate()
            if isTimeOut == true {
                swipeQuizExamView.timerLabel.text = "Конец экзамена"
                guard let examViewModel = examViewModel else { return }
//                presenter?.gradeCloseView(examViewModel: examViewModel)
            }
        }
    }
    
}

//MARK: - Private methods
extension SwipeQuizExamViewController {
    private func setup() {
        swipeQuizExamView.cardStack.delegate = self
        swipeQuizExamView.cardStack.dataSource = self
        swipeQuizExamView.updateView(name: "Перетащите карточку к нужному слову.\nНажми на карточку для подсказки")
//        changeAnwers(words: words, index: 0)
    }
    
    private func setupNavigationItems() {
        guard let cardsCount = words?.count else { return }
        title = "\(currentCardNumber) из \(cardsCount)"
        
        navigationController?.navigationBar.tintColor = .systemOrange
        let closeImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(closeTapped))
    }
    
    private func setupExamVM() {
        guard let cardsCount = words?.count else { return }
        examViewModel = ExamViewModel(name: "", isPassed: false, grade: 0, questions: cardsCount, description: "")
    }
    
    @objc private func closeTapped() {
        presenter?.closeView()
    }
        
    private func checkAnswer(name: String, side: String) {
        guard var examViewModel = examViewModel else { return }
        if name == side {
            examViewModel.grade += 1
            self.examViewModel = examViewModel
        } else {
            isTimeOut = false
//            presenter?.gradeCloseView(examViewModel: examViewModel)
        }
    }
    
    private func changeAnwers(words: [ContentLessonViewModel], index: Int) {
        let wordsArr = randomWords(mainWord: words[index].translate, words: words)
        swipeQuizExamView.updateAnswers(top: wordsArr[0],
                                 right: verticalTextConverter(text: wordsArr[1]),
                                 bot: wordsArr[2],
                                 left: verticalTextConverter(text: wordsArr[3]))
    }
}


//MARK: - SwipeQuizExamViewProtocol
extension SwipeQuizExamViewController: SwipeQuizExamViewProtocol {
}

//MARK: - SwipeCardStackDelegate
extension SwipeQuizExamViewController: SwipeCardStackDelegate {

    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        self.showAlarm(title: "", message: LocalisationManager.flipError)
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        guard let words = words else { return }
        if isSwipped == true && currentCardNumber + 1 <= words.count {
            currentCardNumber += 1
            title = "\(currentCardNumber) / \(words.count)"
        }
        
        switch direction {
        case .left:
            let name = verticalTextConverter(text: words[index].translate)
            checkAnswer(name: name, side: swipeQuizExamView.leftLabel.text ?? "")
        case .right:
            let name = verticalTextConverter(text: words[index].translate)
            checkAnswer(name: name, side: swipeQuizExamView.rightLabel.text ?? "")
        case .up:
            let name = words[index].translate
            checkAnswer(name: name, side: swipeQuizExamView.topLabel.text ?? "")
        case .down:
            let name = words[index].translate
            checkAnswer(name: name, side: swipeQuizExamView.bottomLabel.text ?? "")
        default:
            print("cardStack swipe error")
        }
        
        if cardStack.topCardIndex == nil {
            isTimeOut = false
            guard var examViewModel = examViewModel else { return }
//            presenter?.gradeCloseView(examViewModel: examViewModel)
//            presenter?.gradeCloseView(grade: grade, isExamPass: isExamPass)
        } else {
            changeAnwers(words: words, index: index + 1)
        }
        
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print(index)
    }
}

//MARK: - SwipeCardStackDataSource
extension SwipeQuizExamViewController: SwipeCardStackDataSource {
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        guard let words = words else { return SwipeCard() }
        return card(word: words[index].name, imageName: words[index].image, translation: words[index].translate, transcription: "")
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return words?.count ?? 0
    }
    
    func card(word: String, imageName: String, translation: String, transcription: String?) -> SwipeCard {
        let card = CardView(name: word, transcription: transcription)//SwipeCard()
        card.cardCellDelegate = self
        card.swipeDirections = [.left, .right, .up, .down]
        
        let leftOverlay = UIView()
        leftOverlay.layer.cornerRadius = 25
        leftOverlay.backgroundColor = ColorLib.realLil.color
        
        let rightOverlay = UIView()
        rightOverlay.backgroundColor = ColorLib.realGreen.color
        rightOverlay.layer.cornerRadius = 25
        
        let upOverlay = UIView()
        upOverlay.backgroundColor = ColorLib.realBlue.color
        upOverlay.layer.cornerRadius = 25
        
        let downOverlay = UIView()
        downOverlay.backgroundColor = ColorLib.realYellow.color
        downOverlay.layer.cornerRadius = 25
        
        card.setOverlays([.left: leftOverlay, .right: rightOverlay, .up: upOverlay, .down: downOverlay])
        
        return card
    }
    
}

//MARK: - SwipeCardStackDataSource
extension SwipeQuizExamViewController: CardCellDelegate {
    func soundTappd(cell: SwipeCard) {
        //self.showAlarm(title: "", message: Constants.soundInProgressText)
    }
    
    func giveIndexByCard(swipeCard: SwipeCard) -> Int {
        let count = 0
        guard let words = words else { return 0 }
        for card in words {
            if swipeCard == swipeQuizExamView.cardStack.card(forIndexAt: card.id) {
                return card.id
            }
        }
        return count
    }
    
}
////MARK: - SwipeCardStackDataSource
//extension SwipeQuizExamViewController: TotalUserCardsDelegate {
//    func close() {
////        presenter?.router?.dismissUserCards(from: self, completion: nil)
//    }
    
//}
