//
//  Algoritms.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 04.02.25.
//

func verticalTextConverter(text: String) -> String {
    let vertical = text.map { "\($0)" }.joined(separator: "\n")
    return vertical
}

func wordsVMtoNames(wordsVM: [ContentLessonViewModel]) -> [String] {
    var wordsNames: [String] = []
    for wordVM in wordsVM {
        wordsNames.append(wordVM.translate)
    }
    return wordsNames
}

func randomWords(mainWord: String, words: [ContentLessonViewModel]) -> [String]{
    var randomNames: [String] = []
    var count = 0
    let wordsNames: [String] = wordsVMtoNames(wordsVM: words)
    
    while count != 4 {
        let word = wordsNames[Int.random(in: 0...wordsNames.count - 1)]
        if randomNames.contains(word) == true {
            
        } else {
            randomNames.append(word)
            count += 1
        }
    }
    
    if randomNames.contains(mainWord) == false {
        randomNames[Int.random(in: 0...3)] = mainWord
    }
    
    return randomNames
}
