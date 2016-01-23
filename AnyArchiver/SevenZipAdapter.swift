//
//  SevenZipAdapter.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 21..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation
import UltimateFramework
import SevenZip

extension SVZArchiveEntry: IArchiveEntry {
}

class SevenZipArchive: IArchive {
    private let _archive: SVZArchive
    
    init(archive: SVZArchive) {
        _archive = archive
    }
    
    // from IArchive:
    
    var entries: [IArchiveEntry] { return _archive.entries.map({ $0 as IArchiveEntry }) }
    
    func updateEntries(newEntries: [IArchiveEntry]) throws {
        try _archive.updateEntries(newEntries as! [SVZArchiveEntry])
    }
}

class SevenZipArchiver: IArchiver {

    let type: ArchiverType = .SevenZip

    func archiveWithURL(url: NSURL, createIfMissing create: Bool) throws -> IArchive {
        let svzArchive = try SVZArchive(URL: url, createIfMissing: create)
        return SevenZipArchive(archive: svzArchive)
    }
    
    func archiveEntryWithName(name: String, url: NSURL?) -> IArchiveEntry {
        guard let url = url else {
            return SVZArchiveEntry(directoryName: name)!
        }
        
        return SVZArchiveEntry(fileName: name, contentsOfURL: url)!
    }

}

