//
//  Database+Table.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/// Extension database for create qpp table
extension Database {
    
    func createTable() throws {
        try? self.createEntityTable()
    }
    
    /// 建立entity表
    private func createEntityTable() throws {
        try self.create(table: Entity.databaseTableName, temporary: false, ifNotExists: true) { t in
            t.autoIncrementedPrimaryKey(Entity.Columns.id.name)
            t.column(Entity.Columns.attribute.name, .text).notNull()
        }
    }
}
