//
//  PortableWriter.swift
//  AnyArchiver
//
//  Created by Tamás Lustyik on 2016. 01. 23..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public class PortableWriter {
    
    private let _archiver: IArchiver
    
    public init(archiver: IArchiver) {
        _archiver = archiver
    }

    public func setVersion(version: Int, forPortableAtURL url: NSURL) throws {
        let archive = try _archiver.archiveWithURL(url, createIfMissing: false)

        let jsonData = ("{\"version\":\(version)}" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let newEntry = _archiver.archiveEntryWithName("metadata.json", data: jsonData)

        var entries = archive.entries
        entries.append(newEntry)
        try archive.updateEntries(entries)
    }
}
