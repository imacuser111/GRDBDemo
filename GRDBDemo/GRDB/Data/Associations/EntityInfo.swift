//
//  EntityInfo.swift
//  GRDBDemo
//
//  Created by Cheng-Hong on 2022/9/26.
//

import Foundation
import GRDB

// Fetch all authors along with their books
struct EntityInfo: Decodable, FetchableRecord {
    var entity: Entity // The base record
    var associations: [Association]  // A collection of associated records
}

//let entityInfo = try Entity
//    .including(all: Entity.associaitons)
//    .asRequest(of: EntityInfo.self)
//    .fetchAll(db)
