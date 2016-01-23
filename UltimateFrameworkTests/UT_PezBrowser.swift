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

class UT_PezBrowser: QuickSpec {
    override func spec() {
        var sut: PezBrowser!
        var archiverMock: UTArchiver!
        var archiveMock: UTArchive!
        var archiverFactoryMock: UTArchiverFactory!

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
            
            sut = PezBrowser(factory: archiverFactoryMock)
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
                expect(archiverMock.didOpen).to(beTrue())
            }
            
            it("extracts the entry containing the preview") {
                // then
                expect(UTArchiveEntry.lastExtractedEntry).to(equal("prezi/preview.png"))
            }
        }
    }
    
}
