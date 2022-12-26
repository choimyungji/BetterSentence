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
        sut = SentenceStorage()
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_addSentence() {
        let count = sut.sentences.count

        let sentence = Sentence(sentence: "안녕하세요", author: "Martin", time: Date())
        sut.add(sentence: sentence)

        XCTAssertEqual(sut.sentences.count, count+1)
    }

}
