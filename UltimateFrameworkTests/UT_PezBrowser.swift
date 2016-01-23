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
import Cocoa
import ZipZap

class UT_PezBrowser: QuickSpec {
    override func spec() {
        var sut: PezBrowser!

        beforeEach {
            sut = PezBrowser()
        }

        describe("getting the preview") {
            it("extracts the entry containing the preview") {
                // given
                let url = NSBundle(forClass: UT_PezBrowser.self).URLForResource("test", withExtension: "pez")!
                
                let archive = try! ZZArchive(URL: url)
                var expectedData: NSData!
                for entry in archive.entries {
                    if entry.fileName == "prezi/preview.png" {
                        expectedData = try! entry.newData()
                        break
                    }
                }
                
                // when
                let result = try? sut.previewDataForPezAtURL(url)
                
                // then
                expect(result).notTo(beNil())
                expect(result).to(equal(expectedData))
            }
        }
    }
    
}
