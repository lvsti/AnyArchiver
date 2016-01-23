//
//  Archivers.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol IArchiver {
    func archiveWithURL(url: NSURL) throws -> IArchive
}

public protocol IArchive {
    var entries: [IArchiveEntry] { get }
}

public protocol IArchiveEntry {
    var name: String { get }
    func extractedData() throws -> NSData
}


