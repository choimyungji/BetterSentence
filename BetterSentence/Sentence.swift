//
//  Sentence.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2021/02/04.
//

import Foundation

struct Sentence: Codable {
    var id: String
    var sentence: String
    var author: String
    var time: Date?

    init(id: String = UUID().uuidString, sentence: String, author: String, time: Date? = nil) {
        self.id = id
        self.sentence = sentence
        self.author = author
        self.time = time
    }
}

