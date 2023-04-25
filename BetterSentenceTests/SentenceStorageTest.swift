//
//  SentenceStorageTest.swift
//  BetterSentenceTests
//
//  Created by Myungji Choi on 2022/12/26.
//

@testable import BetterSentence
import XCTest

final class SentenceStorageTest: XCTestCase {
    var sut: SentenceStorage!

    override func setUp() {
        super.setUp()
        sut = SentenceStorage.shared
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_addSentence() {
        let count = sut.sentences.count

        let sentence = Sentence(id: UUID().uuidString, sentence: "안녕하세요", author: "Martin", time: Date())
        sut.add(sentence: sentence)

        XCTAssertEqual(sut.sentences.count, count+1)
    }

    func test_deleteSentence() {

        let sentence1 = Sentence(id: UUID().uuidString, sentence: "안녕하세요", author: "Martin", time: Date())
        sut.add(sentence: sentence1)

        let sentence2 = Sentence(id: UUID().uuidString, sentence: "안녕하세요", author: "Martin", time: Date())
        sut.add(sentence: sentence2)

        let sentence3 = Sentence(id: UUID().uuidString, sentence: "안녕하세요", author: "Martin", time: Date())
        sut.add(sentence: sentence3)

        let count = sut.sentences.count
        
        if let sentenceId = sut.sentences.first?.id {
            sut.deleteSentence(id: sentenceId)
        }

        XCTAssertEqual(sut.sentences.count, count-1)
    }

}
