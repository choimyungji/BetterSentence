//
//  Document.swift
//  BetterSentence
//
//  Created by Myungji Choi on 2023/02/10.
//

import UIKit

class Document: UIDocument {
    var sentences: [Sentence] = []

    override func contents(forType typeName: String) throws -> Any {
        let json = try? JSONEncoder().encode(sentences)
        return json ?? Data()
    }

    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let userContent = contents as? Data {
            do {
                sentences = try JSONDecoder().decode([Sentence].self, from: userContent)
            } catch {
                sentences = []
            }
        }
    }
}
