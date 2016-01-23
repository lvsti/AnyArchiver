//
//  ZipZapAdapter.swift
//  AnyArchiver
//
//  Created by Tamas Lustyik on 2015. 12. 20..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation
import ZipZap

public enum ZipZapErrorType: ErrorType {
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
}

public class ZipZapArchiver: IArchiver {
    
    public init() {}
    
    public func archiveWithURL(url: NSURL) throws -> IArchive {
        let zzArchive = try ZZArchive(URL: url)
        return ZipZapArchive(archive: zzArchive)
    }

}
