//
//  UTArchiver.swift
//  AnyArchiver
//
//  Created by Tamás Lustyik on 2016. 01. 23..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation
import UltimateFramework

class UTArchiverFactory: IArchiverFactory {
    var archiver: IArchiver? = nil
    var lastRequestedType: ArchiverType? = nil
    
    func archiverForType(type: ArchiverType) -> IArchiver? {
        lastRequestedType = type
        return archiver
    }
}

class UTArchiver: IArchiver {
    var didOpen: Bool = false
    var archive: IArchive? = nil

    var type: ArchiverType = .Zip
    
    func archiveWithURL(url: NSURL, createIfMissing: Bool) throws -> IArchive {
        didOpen = true
        return archive!
    }

    func archiveEntryWithName(name: String, data: NSData?) -> IArchiveEntry {
        return UTArchiveEntry(name: name, data: NSData())
    }
}

class UTArchive: IArchive {
    var lastUpdatedEntries: [IArchiveEntry]? = nil
    var entries: [IArchiveEntry] = []
    func updateEntries(newEntries: [IArchiveEntry]) throws {
        lastUpdatedEntries = newEntries
    }
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

