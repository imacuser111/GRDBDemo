//
//  Associations.swift
//  GRDBDemo
//
//  Created by Cheng-Hong on 2022/9/26.
//

import GRDB
import RxGRDB
import RxSwift

/// Associations is responsible for high-level operations on the Entitys database.
struct Associations {
    private let dbWriter: DatabaseWriter
    
    init(dbWriter: DatabaseWriter) {
        self.dbWriter = dbWriter
    }
    
    // MARK: - Modify Entitys
    
    func rx_insert(_ entity: Association) -> Single<Void> {
        dbWriter.rx.write(updates: { db in try _insert(db, entity: entity) })
    }
    
    func rx_deleteAll() -> Single<Void> {
        dbWriter.rx.write(updates: _deleteAll)
    }
    
    func rx_deleteOne(_ entity: Association) -> Single<Void> {
        dbWriter.rx.write(updates: { db in try _deleteOne(db, entity: entity) })
    }
    
    // MARK: - Access Entitys
    
    func fetchAll() -> Observable<[Association]> {
        ValueObservation
            .tracking(_fetchAll)
            .rx.observe(in: dbWriter)
    }
    
    /// An observable that tracks changes in the Entitys
    func entitysOrderedByID() -> Observable<[Association]> {
        ValueObservation
            .tracking(Association.all().orderByID().fetchAll)
            .rx.observe(in: dbWriter)
    }
    
    // MARK: - Implementation
    //
    // ⭐️ Good practice: when we want to update the database, we define methods
    // that accept a Database connection, because they can easily be composed.
    
    private func _insert(_ db: Database, entity: Association) throws {
        try entity.insert(db)
    }
    
    private func _deleteAll(_ db: Database) throws {
        try Association.deleteAll(db)
    }
    
    private func _deleteOne(_ db: Database, entity: Association) throws {
        try entity.delete(db)
    }
    
    private func _update(_ db: Database, entity: Association) throws {
        try entity.update(db)
    }
    
    private func _fetchAll(_ db: Database) throws -> [Association] {
        try Association.fetchAll(db)
    }
}

// MARK: - Entity Database Requests

// Define requests of entitys in a constrained extension to the DerivableRequest protocol.
extension DerivableRequest where RowDecoder == Association {
    func orderByID() -> Self {
        return order(RowDecoder.Columns.id.desc)
    }
}

// MARK: - For Swift

extension Associations {
    
    // MARK: - Modify Entitys
    
    /// 新增entity
    /// - Parameter entity: 實例
    func insert(_ entity: Association) throws {
        try dbWriter.write { db in try _insert(db, entity: entity) }
    }
    
    /// 刪除所有entity
    func deleteAll() throws {
        _ = try dbWriter.write(_deleteAll)
    }
    
    /// 刪除單個entity
    /// - Parameter entity: 實例
    func deleteOne(_ entity: Association) throws {
        _ = try dbWriter.write { db in try _deleteOne(db, entity: entity) }
    }
    
    /// 更新entity
    /// - Parameter entity: 實例
    func update(_ entity: Association) throws {
        try dbWriter.write { db in try _update(db, entity: entity)}
    }
    
    // MARK: - Access Entitys
    
    /// 讀取entity
    /// - Returns: 所有實例
    func fetchAll() throws -> [Association] {
        try dbWriter.read(_fetchAll)
    }
}
