//
//  UTArchiver.swift
//  AnyArchiver
//
//  Created by Tamás Lustyik on 2016. 02. 02..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

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

