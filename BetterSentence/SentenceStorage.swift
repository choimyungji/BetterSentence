//
//  SentenceStorage.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2022/09/19.
//

import Foundation

final class SentenceStorage {
    var sentences: [Sentence] = exampleSentence
}

let exampleSentence: [Sentence] = [
    Sentence(sentence: "GitHub앱 위젯이 생겼으니 매일매일 다시 해보자", author: "Martin Choi", time: Date()),
    Sentence(sentence: "있을때 잘하란 말을 구체적으로 실천할 수 있도록 계획해야겠다.", author: "Martin Choi", time: Date()),
    Sentence(sentence: "아이가 나의 어떤 모습을 보고 하루를 보낼지 생각해보자.", author: "Martin Choi", time: Date())
]
