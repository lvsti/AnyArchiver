//
//  Archivers.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol IArchiverFactory {
    func archiverForType(type: ArchiverType) -> IArchiver?
}

public protocol IArchiver {
    var type: ArchiverType { get }
    func archiveWithURL(url: NSURL, createIfMissing: Bool) throws -> IArchive
    func archiveEntryWithName(name: String, data: NSData?) -> IArchiveEntry
}

public protocol IArchive {
    var entries: [IArchiveEntry] { get }
    func updateEntries(newEntries: [IArchiveEntry]) throws
}

public protocol IArchiveEntry {
    var name: String { get }
    func extractedData() throws -> NSData
}


