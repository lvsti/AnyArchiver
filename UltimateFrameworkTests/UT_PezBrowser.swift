//
//  UT_PezBrowser.swift
//  UltimateFrameworkTests
//
//  Created by Tamás Lustyik on 2016. 01. 23..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Quick
import Nimble
import UltimateFramework

class UTArchiver: IArchiver {
    var didOpen: Bool = false
    var archive: IArchive? = nil

    func archiveWithURL(url: NSURL) throws -> IArchive {
        didOpen = true
        return archive!
    }
}

class UTArchive: IArchive {
    var entries: [IArchiveEntry] = []
}

class UTArchiveEntry: IArchiveEntry {
    static var lastExtractedEntry: String? = nil
    let name: String
    let data: NSData
    
    init(name: String, data: NSData) {
        self.name = name
        self.data = data
    }
    
    func extractedData() throws -> NSData {
        UTArchiveEntry.lastExtractedEntry = name
        return NSData()
    }
}

class UT_PezBrowser: QuickSpec {
    override func spec() {
        var sut: PezBrowser!
        var archiverMock: UTArchiver!
        var archiveMock: UTArchive!

        beforeEach {
            archiveMock = UTArchive()
            archiveMock.entries = [
                UTArchiveEntry(name: "foo/bar.txt", data: NSData()),
                UTArchiveEntry(name: "prezi/preview.png", data: NSData())
            ]

            archiverMock = UTArchiver()
            archiverMock.archive = archiveMock
            
            sut = PezBrowser(archiver: archiverMock)
        }

        describe("getting the preview") {
            beforeEach {
                // given
                let url = NSURL(fileURLWithPath: "/foo/bar.pez")
                
                // when
                let _ = try? sut.previewDataForPezAtURL(url)
            }

            it("opens the pez as archive") {
                // then
                expect(archiverMock.didOpen).to(beTrue())
            }
            
            it("extracts the entry containing the preview") {
                // then
                expect(UTArchiveEntry.lastExtractedEntry).to(equal("prezi/preview.png"))
            }
        }
    }
    
}
