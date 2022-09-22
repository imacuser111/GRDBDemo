//
//  Entity.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/// The Entity struct.
///
/// Identifiable conformance supports SwiftUI list animations, and type-safe
/// GRDB primary key methods.
/// Equatable conformance supports tests.
struct Entity: Identifiable, Equatable {
    /// The entity id.
    ///
    /// Int64 is the recommended type for auto-incremented database ids.
    /// Use nil for entitys that are not inserted yet in the database.
    var id: Int64?
    var attribute: String?
    
    /// Creates a new entity
    static func new(id: Int64? = nil, attribute: String? = nil) -> Entity {
        Entity(id: id, attribute: attribute)
    }
}

// MARK: - Persistence

/// Make entity a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Entity: Codable, FetchableRecord, PersistableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let attribute = Column(CodingKeys.attribute)
    }
    
    // For a non-codable record
    // Define database columns as an enum
//    enum Columns: String, ColumnExpression {
//        case id, attribute
//    }
    
    internal mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
