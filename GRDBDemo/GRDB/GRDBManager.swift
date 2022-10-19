//
//  GRDBManager.swift
//  TestRxCoreData
//
//  Created by Cheng-Hong on 2022/9/19.
//

import Foundation
import GRDB

/// GRDBManager lets the application access the database.
///
/// It applies the pratices recommended at
/// https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md
final class GRDBManager {
    
    /// The database for the application
    static let shared = makeShared()

    static let fileName = "RxCoreData.sqlite"
    
    /// Provides access to the database.
    ///
    /// Application can use a `DatabasePool`, and tests can use a fast
    /// in-memory `DatabaseQueue`.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
    let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
//        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        // 2. Define the database schema
        migrator.registerMigration("v1") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.createTable()
        }
        
//        migrator.registerMigration("v2") { db in
//            if #available(iOS 15.0, *) {
//                try db.alter(table: Entity.databaseTableName) { t in
//                    t.drop(column: Entity.Columns.attribute.name)
//                }
//            } else {
//                // Turn uuid into a text column
//                try db.create(table: "new_\(Entity.databaseTableName)") { t in
//                    t.autoIncrementedPrimaryKey(Entity.Columns.id.name)
//                }
//
//                let rows = try Row.fetchCursor(db, sql: "SELECT * FROM \(Entity.databaseTableName)")
//                while let row = try rows.next() {
//                    try db.execute(
//                        sql: "INSERT INTO new_\(Entity.databaseTableName) (id) VALUES (?)",
//                        arguments: [
//                            row["id"]
//                        ])
//                }
//
//                try db.drop(table: Entity.databaseTableName)
//                try db.rename(table: "new_\(Entity.databaseTableName)", to: Entity.databaseTableName)
//            }
//        }
//
//        migrator.registerMigration("v3") { db in
//            try db.alter(table: Entity.databaseTableName) { t in
//                t.add(column: Entity.Columns.attribute.name, .text)
//            }
//        }
        
        return migrator
    }
    
    /// Creates an `GRDBManager`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    private static func makeShared() -> GRDBManager {
        do {
            // Create a folder for storing the SQLite database, as well as
            // the various temporary files created during normal database
            // operations (https://sqlite.org/tempfiles.html).
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(Self.fileName)
            
            // 1. Open a database connection
            let dbQueue = try DatabaseQueue(path: fileURL.path)
            
            // Create the GRDBManager
            let manager = try GRDBManager(dbQueue)
            
            // Populate the database if it is empty, for better demo purpose.
    //            try manager.createRandomPlayersIfEmpty()
            
            return manager
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate.
            //
            // Typical reasons for an error here include:
            // * The parent directory cannot be created, or disallows writing.
            // * The database is not accessible, due to permissions or data protection when the device is locked.
            // * The device is out of space.
            // * The database could not be migrated to its latest schema version.
            // Check the error message to determine what the actual problem was.
            fatalError("Unresolved error \(error)")
        }
    }
}
