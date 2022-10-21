//
//  AssociationInfo.swift
//  GRDBDemo
//
//  Created by Cheng-Hong on 2022/9/26.
//

import Foundation
import GRDB

struct AssociationInfo: FetchableRecord, Decodable {
    let associaiton: Association
    let entity: Entity
}

extension Entity {
    static let associaitons = hasMany(Association.self)
    var associaitons: QueryInterfaceRequest<Association> {
        request(for: Entity.associaitons)
    }
}

extension Association {
    // TODO: - 一個主Key綁定多個foreignKey需要告訴GRDB要綁哪個
    // https://github.com/groue/GRDB.swift/blob/master/Documentation/AssociationsBasics.md#foreign-keys
//    static let entityForeignKey = ForeignKey(["entityID"])
//    static let entity = belongsTo(Entity.self, using: entityForeignKey)
    
    static let entity = belongsTo(Entity.self)
    var entity: QueryInterfaceRequest<Entity> {
        request(for: Association.entity)
    }
}
