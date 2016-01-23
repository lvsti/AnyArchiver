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

class UTArchiverFactory: IArchiverFactory {
    var lastRequestedType: ArchiverType? = nil
    var archiver: IArchiver? = nil
    
    func archiverForType(type: ArchiverType) -> IArchiver? {
        lastRequestedType = type
        return archiver
    }
}

class UTArchiver: IArchiver {
    var lastInvocation: (String, [Any])? = nil
    var archive: IArchive? = nil
    var archiveEntry: IArchiveEntry? = nil

    var type: ArchiverType { return .Zip }
    
    func archiveWithURL(url: NSURL, createIfMissing: Bool) throws -> IArchive {
        lastInvocation = (__FUNCTION__, [url, createIfMissing])
        return archive!
    }
    
    func archiveEntryWithName(name: String, url: NSURL?) -> IArchiveEntry {
        lastInvocation = (__FUNCTION__, [name, url])
        return archiveEntry!
    }
}

class UTArchive: IArchive {
    var entries: [IArchiveEntry] = []
    func updateEntries(newEntries: [IArchiveEntry]) throws {}
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
        var archiverFactoryMock: UTArchiverFactory!
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
            
            archiverFactoryMock = UTArchiverFactory()
            archiverFactoryMock.archiver = archiverMock
            
            sut = PezBrowser(archiverFactory: archiverFactoryMock)
        }

        describe("initialization") {
            it("requests a zip archiver") {
                // then
                expect(archiverFactoryMock.lastRequestedType).to(equal(ArchiverType.Zip))
            }
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
                expect(archiverMock.lastInvocation?.0).to(equal("archiveWithURL(_:createIfMissing:)"))
            }
            
            it("extracts the entry containing the preview") {
                // then
                expect(UTArchiveEntry.lastExtractedEntry).to(equal("prezi/preview.png"))
            }
        }
    }
    
}
