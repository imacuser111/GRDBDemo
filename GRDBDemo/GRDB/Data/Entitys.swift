//
//  Entitys.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/20.
//

import GRDB
import RxGRDB
import RxSwift

enum DBError: Error {
    case notSearch
}

/// Entitys is responsible for high-level operations on the Entitys database.
struct Entitys {
    private let dbWriter: DatabaseWriter
    
    init(dbWriter: DatabaseWriter) {
        self.dbWriter = dbWriter
    }
    
    // MARK: - Modify Entitys
    
    func rx_insert(_ entity: Entity) -> Single<Void> {
        dbWriter.rx.write(updates: { db in try _insert(db, entity: entity) })
    }
    
    func rx_deleteAll() -> Single<Void> {
        dbWriter.rx.write(updates: _deleteAll)
    }
    
    func rx_deleteOne(_ entity: Entity) -> Single<Void> {
        dbWriter.rx.write(updates: { db in try _deleteOne(db, entity: entity) })
    }
    
    func rx_deleteOne(_ id: Int64) -> Single<Void> {
        guard let entity = try? fetchAll().filter({ $0.id == id }).first else { return .error(DBError.notSearch) }
        
        return rx_deleteOne(entity)
    }
    
    func rx_update(_ entity: Entity) -> Single<Void> {
        dbWriter.rx.write(updates: { db in try _update(db, entity: entity) })
    }
    
    // MARK: - Access Entitys
    
    func rx_fetchAll() -> Observable<[Entity]> {
        ValueObservation
            .tracking(_fetchAll)
            .rx.observe(in: dbWriter)
    }
    
    /// An observable that tracks changes in the Entitys
    func entitysOrderedByScore() -> Observable<[Entity]> {
        ValueObservation
            .tracking(Entity.all().orderByID().fetchAll)
            .rx.observe(in: dbWriter)
    }
    
    /// An observable that tracks changes in the Entitys
    func entitysOrderedByName() -> Observable<[Entity]> {
        ValueObservation
            .tracking(Entity.all().orderByAttribute().fetchAll)
            .rx.observe(in: dbWriter)
    }
    
    // MARK: - Implementation
    //
    // ⭐️ Good practice: when we want to update the database, we define methods
    // that accept a Database connection, because they can easily be composed.
    
    private func _insert(_ db: Database, entity: Entity) throws {
        try entity.insert(db)
    }
    
    private func _deleteAll(_ db: Database) throws {
        try Entity.deleteAll(db)
    }
    
    private func _deleteOne(_ db: Database, entity: Entity) throws {
        try entity.delete(db)
    }
    
    private func _update(_ db: Database, entity: Entity) throws {
        try entity.update(db)
    }
    
    private func _fetchAll(_ db: Database) throws -> [Entity] {
        try Entity.fetchAll(db)
    }
}

// MARK: - Entity Database Requests

// Define requests of entitys in a constrained extension to the DerivableRequest protocol.
extension DerivableRequest where RowDecoder == Entity {
    func orderByID() -> Self {
        return order(RowDecoder.Columns.id.desc, RowDecoder.Columns.attribute)
    }
    
    func orderByAttribute() -> Self {
        return order(RowDecoder.Columns.attribute, RowDecoder.Columns.id.desc)
    }
    
    func filterAttribute(_ str: String) -> Self {
        filter(Entity.Columns.attribute == str)
    }
}

// MARK: - For Swift

extension Entitys {
    
    // MARK: - Modify Entitys
    
    /// 新增entity
    /// - Parameter entity: 實例
    func insert(_ entity: Entity) throws {
        try dbWriter.write { db in try _insert(db, entity: entity) }
    }
    
    /// 刪除所有entity
    func deleteAll() throws {
        _ = try dbWriter.write(_deleteAll)
    }
    
    /// 刪除單個entity
    /// - Parameter entity: 實例
    func deleteOne(_ entity: Entity) throws {
        _ = try dbWriter.write { db in try _deleteOne(db, entity: entity) }
    }
    
    /// 更新entity
    /// - Parameter entity: 實例
    func update(_ entity: Entity) throws {
        try dbWriter.write { db in try _update(db, entity: entity)}
    }
    
    // MARK: - Access Entitys
    
    /// 讀取entity
    /// - Returns: 所有實例
    func fetchAll() throws -> [Entity] {
        try dbWriter.read(_fetchAll)
    }
}
