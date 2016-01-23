//
//  ArchiverFactory.swift
//  AnyArchiver
//
//  Created by Tamás Lustyik on 2016. 01. 23..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation


public class ArchiverFactory: IArchiverFactory {
    private static var _archivers: [ArchiverType: IArchiver] = [:]
    
    public init() {}
    
    public static func registerArchiver(archiver: IArchiver) {
        _archivers[archiver.type] = archiver
    }
    
    public func archiverForType(type: ArchiverType) -> IArchiver? {
        return ArchiverFactory._archivers[type]
    }
    
}

