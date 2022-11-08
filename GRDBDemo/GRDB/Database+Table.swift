//
//  Database+Table.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/* 關聯使用範例 */

// (1) 建表拉關聯 Entity.databaseTableName -> 你要關聯的表，column: 你要關聯的值，onDelete: 要刪除的規則

// (2) Associations 底下創建struct

// (3) 創建要求: belongsTo: 子表屬於哪張主表(Entity.self)，這邊示範的是子表，如果你是主表則會用hasMany or hasOne 取決於你這張表底下有幾個子元素

// (4) 創建變數: 塞入剛剛創建的條件取出主表

//private func createAssociationTable() throws {
//    try self.create(table: Association.databaseTableName) { t in
//        t.autoIncrementedPrimaryKey(Association.Columns.id.name)
//
//        // (1) 在你要關聯的值設定 .references
//        t.column(Association.Columns.entityID.name)
//            .notNull()
//            .indexed()
////                .references(Entity.databaseTableName, column: Entity.Columns.id, onDelete: .none)
//            .references(Entity.databaseTableName, onDelete: .none)
//    }
//}

// (2) 子表
//struct AssociationInfo: FetchableRecord, Decodable {
//    let associaiton: Association
//    let entity: Entity
//}
//
//extension Association {
//    // (3)
//    static let entity = belongsTo(Entity.self)
//
//    // (4)
//    var entity: QueryInterfaceRequest<Entity> {
//        request(for: Association.entity)
//    }
//}

/// Extension database for create qpp table
extension Database {
    
    func createTable() throws {
        try self.createEntityTable()
        try self.createAssociationTable()
    }
    
    /// 建立entity表
    private func createEntityTable() throws {
        try self.create(table: Entity.databaseTableName) { t in
            t.autoIncrementedPrimaryKey(Entity.Columns.id.name)
            t.column(Entity.Columns.attribute.name, .text).notNull()
        }
    }
    
    private func createAssociationTable() throws {
        try self.create(table: Association.databaseTableName) { t in
            t.autoIncrementedPrimaryKey(Association.Columns.id.name)
            t.column(Association.Columns.entityID.name)
                .notNull()
                .indexed()
//                .references(Entity.databaseTableName, column: Entity.Columns.id, onDelete: .none)
                .references(Entity.databaseTableName, onDelete: .none)
        }
    }
}
