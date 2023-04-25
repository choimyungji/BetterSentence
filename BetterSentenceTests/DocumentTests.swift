//
//  DocumentTests.swift
//  BetterSentenceTests
//
//  Created by Myungji Choi on 2023/02/12.
//

import XCTest
@testable import BetterSentence

final class DocumentTests: XCTestCase {

    var sut: Document?
    var ubiquityURL: URL?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SaveFiles() {
        let fileManager = FileManager.default

        ubiquityURL = fileManager.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        ubiquityURL = ubiquityURL?.appendingPathComponent("savefile.txt")

        let metaDataQuery = NSMetadataQuery()
        metaDataQuery.predicate = NSPredicate(format: "%K like 'savefile.txt'", NSMetadataItemFSNameKey)
        metaDataQuery.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(metadataQueryDidFinishGathering),
                                               name: Notification.Name.NSMetadataQueryDidFinishGathering,
                                               object: metaDataQuery)
        metaDataQuery.start()
    }

    func metadataQueryDidFinishGathering(notification: NSNotification) -> Void { }
}
