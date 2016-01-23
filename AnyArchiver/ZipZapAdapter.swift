//
//  ZipZapAdapter.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation
import UltimateFramework
import ZipZap

enum ZipZapErrorType: ErrorType {
    case NewEntry
}

extension ZZArchiveEntry: IArchiveEntry {
    public var name: String { return fileName }
    
    public func extractedData() throws -> NSData {
        if crc32 == 0 {
            throw ZipZapErrorType.NewEntry
        }
        return try newData()
    }
}

class ZipZapArchive: IArchive {
    private let _archive: ZZArchive

    init(archive: ZZArchive) {
        _archive = archive
    }
    
    // from IArchive:
    
    var entries: [IArchiveEntry] { return _archive.entries.map({ $0 as IArchiveEntry }) }
    
    func updateEntries(newEntries: [IArchiveEntry]) throws {
        try _archive.updateEntries(newEntries as! [ZZArchiveEntry])
    }
}

class ZipZapArchiver: IArchiver {
    
    let type: ArchiverType = .Zip

    func archiveWithURL(url: NSURL, createIfMissing create: Bool) throws -> IArchive {
        let zzArchive = try ZZArchive(URL: url, options: [ZZOpenOptionsCreateIfMissingKey: create])
        return ZipZapArchive(archive: zzArchive)
    }
    
    func archiveEntryWithName(name: String, url: NSURL?) -> IArchiveEntry {
        guard let url = url else {
            return ZZArchiveEntry(directoryName: name)
        }
        
        return ZZArchiveEntry(fileName: name, compress: true) { errorPtr in
            return NSData(contentsOfURL: url)
        }
    }
}
