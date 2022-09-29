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
    let entity: Entity?
}

extension Entity {
    static let associaitons = hasMany(Association.self)
    var associaitons: QueryInterfaceRequest<Association> {
        request(for: Entity.associaitons)
    }
}

extension Association {
    static let entity = belongsTo(Entity.self)
    var entity: QueryInterfaceRequest<Entity> {
        request(for: Association.entity)
    }
}
