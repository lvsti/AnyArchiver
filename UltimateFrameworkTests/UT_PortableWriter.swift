//
//  UT_PortableWriter.swift
//  AnyArchiver
//
//  Created by Tamás Lustyik on 2016. 01. 23..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

import Quick
import Nimble
import UltimateFramework

class UT_PortableWriter: QuickSpec {
    override func spec() {
        var sut: PortableWriter!
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
            
            sut = PortableWriter(archiver: archiverMock)
        }

        describe("writing the version") {
            beforeEach {
                // given
                let url = NSURL(fileURLWithPath: "portable-template.7z")
                
                // when
                let _ = try? sut.setVersion(42, forPortableAtURL: url)
            }

            it("opens the portable as archive") {
                // then
                expect(archiverMock.didOpen).to(beTrue())
            }
            
            it("adds a metadata entry to the archive") {
                // then
                expect(archiveMock.lastUpdatedEntries?.count).to(equal(3))
                expect(archiveMock.lastUpdatedEntries?.contains({ e in e.name == "metadata.json" }))
            }
        }
    }
    
}
