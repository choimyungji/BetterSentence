//
//  SentenceStorage.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2022/09/19.
//

import Foundation
import Combine

final class SentenceStorage {

    static let identifier = "group.dev.myungji.sentence"
    static let shared = SentenceStorage()

    var sentences: [Sentence] = []
    var sentencesSubject = CurrentValueSubject<[Sentence], Never>([])

    private var document: Document?
    private let fileManager = FileManager.default
    private var documentURL: URL?

    private init() {
        if let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: Self.identifier) {
            documentURL = directory.appendingPathComponent("Sentence")
            if let documentURL {
                if !fileManager.fileExists(atPath: documentURL.path) {
                    do {
                        try fileManager.createDirectory(at: documentURL, withIntermediateDirectories: false)
                    } catch {
                        print("파일 저장 에러")
                    }
                }

                let filePath = documentURL.appendingPathComponent("savefile.txt")
                if fileManager.fileExists(atPath: filePath.path) {
                    document = Document(fileURL: filePath)
                    document?.open { success in
                        if success {
                            print("Opened document at URL: \(filePath)")
                            if let documentData = self.document?.sentences {
                                self.sentences = documentData
                                self.sentencesSubject.send(self.sentences)
                            }
                        } else {
                            print("Open failed")
                        }
                    }
                } else {
                    self.create(url: filePath)
                }
            }
        }
    }

    private func create(url: URL) {
        let document = Document(fileURL: url)

        document.sentences = exampleSentence
        document.save(to: url, for: .forCreating) { success in
            print("success : \(success)")
        }
    }

    func loadSentence(id: String) -> Sentence? {
        if let data = UserDefaults.standard.data(forKey: id),
           let sentence = try? JSONDecoder().decode(Sentence.self, from: data) {
            return sentence
        } else {
            return nil
        }
    }

    func add(sentence: Sentence) {
        sentences.append(sentence)
        document?.sentences.append(sentence)

        document?.save(to: documentURL!.appendingPathComponent("savefile.txt"), for: .forOverwriting) { success in
            if success {
                print("save OK")
            } else {
                print("save failed")
            }
        }
    }

    func deleteSentence(id: String) {
        sentences.removeAll { $0.id == id }

        document?.sentences = sentences
        document?.save(to: documentURL!.appendingPathComponent("savefile.txt"), for: .forOverwriting) { success in
            if success {
                print("save OK")
            } else {
                print("save failed")
            }
        }
    }
}

let exampleSentence: [Sentence] = [
    Sentence(sentence: "GitHub앱 위젯이 생겼으니 매일매일 다시 해보자", author: "Martin Choi", time: Date()),
    Sentence(sentence: "있을때 잘하란 말을 구체적으로 실천할 수 있도록 계획해야겠다.", author: "Martin Choi", time: Date()),
    Sentence(sentence: "아이가 나의 어떤 모습을 보고 하루를 보낼지 생각해보자.", author: "Martin Choi", time: Date())
]
