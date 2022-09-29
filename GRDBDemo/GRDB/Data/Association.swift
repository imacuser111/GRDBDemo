//
//  Association.swift
//  GRDBDemo
//
//  Created by Cheng-Hong on 2022/9/26.
//

import Foundation
import GRDB

/// The Entity struct.
///
/// Identifiable conformance supports SwiftUI list animations, and type-safe
/// GRDB primary key methods.
/// Equatable conformance supports tests.
struct Association: Identifiable, Equatable {
    /// The entity id.
    ///
    /// Int64 is the recommended type for auto-incremented database ids.
    /// Use nil for entitys that are not inserted yet in the database.
    var id: Int64?
    var entityID: Int64?
    
    /// Creates a new entity
    static func new(id: Int64? = nil, entityID: Int64? = nil) -> Self {
        .init(id: id, entityID: entityID)
    }
}

// MARK: - Persistence

/// Make entity a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Association: Codable, FetchableRecord, PersistableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let entityID = Column(CodingKeys.entityID)
    }
    
    // For a non-codable record
    // Define database columns as an enum
//    enum Columns: String, ColumnExpression {
//        case id
//    }
    
    internal mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

extension GRDBManager {
    /// Access to the entitys database
    var associations: Associations {
        .init(dbWriter: dbWriter)
    }
}
