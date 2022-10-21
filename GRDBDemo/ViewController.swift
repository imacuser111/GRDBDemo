//
//  ViewController.swift
//  GRDBDemo
//
//  Created by Cheng-Hong on 2022/9/22.
//

import UIKit
import RxSwift
import RxCocoa
import GRDB

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: - 綁定變更時通知
        
        let observation = DatabaseRegionObservation(tracking: Entity.all())
        
        // notification(當Entity改變時)
        observation.rx
            .changes(in: GRDBManager.shared.dbWriter)
            .bind {
                print($0, 1111111222223333)
            }
            .disposed(by: disposeBag)
        
        // MARK: - 新增
        
//        do {
//            // 4. Access the database
//            try GRDBManager.shared.dbWriter
//                .write { db in
//                    try Entity(attribute: "Test 1111").insert(db)
//                }
//
//            try GRDBManager.shared.dbWriter
//                .write { db in
//                    try Association(entityID: 1).insert(db)
//                }
//
//        } catch {
//            print(error)
//        }
        
//        GRDBManager.shared.associations
//            .rx_insert(.init(entityID: 5))
//            .subscribe { result in
//                do {
//                    try result.get()
//                } catch {
//                    print(error)
//                }
//            }
//            .disposed(by: disposeBag)
        
        // MARK: - 更新
        
//        let e = try? GRDBManager.shared.entitys
//            .fetchAll()
//            .filter { $0.id == 1 }
//            .first
//
//        do {
//            if var e = e {
//                e.attribute = "update"
//
//                try GRDBManager.shared.entitys
//                    .update(e)
//            }
//
//        } catch {
//            print(error)
//        }
//
//        if var e = e {
//            e.attribute = "aaa"
//
//            GRDBManager.shared.entitys
//                .rx_update(e)
//                .subscribe { result in
//                    print(result)
//                }
//                .disposed(by: disposeBag)
//        }
        
        // MARK: - 刪除單項
        
//        // 刪除單一個entity
//        GRDBManager.shared.entitys
//            .rx_deleteOne(Int64(2))
//            .asObservable()
//            .materialize()
//            .bind {
//                print($0)
//            }
//            .disposed(by: disposeBag)

        // MARK: - 讀取所有
        
        // 讀取所有entitys
//        GRDBManager.shared.entitys
//            .rx_fetchAll()
//            .bind {
//                print($0, 1111111)
//            }
//            .disposed(by: disposeBag)
//
//        // 讀取所有associations
//        GRDBManager.shared.associations
//            .fetchAll()
//            .bind {
//                print($0, 22222)
//            }
//            .disposed(by: disposeBag)
 
//        // MARK: - 讀取關聯的資訊
//
//        // 讀取所有的AssociationInfo
//        try? GRDBManager.shared.dbWriter
//            .read { db in
//                let request = Association.including(optional: Association.entity)
//                let associationInfos = try AssociationInfo.fetchAll(db, request)
//
////                // 一樣結果
////                let associationInfos = try Association
////                    .including(required: Association.entity)
////                    .asRequest(of: AssociationInfo.self)
////                    .fetchAll(db)
//
//                print(associationInfos)
//            }
        
//        // MARK: - 讀取entity attribute == "22233333"的所有元素
//
//        // Swift
//        print(try? GRDBManager.shared.entitys
//            .fetchAll()
//            .filter { $0.attribute == "22233333" })
//
//        // RxSwift
//        try? GRDBManager.shared.entitys
//            .rx_fetchAll()
//            .map { $0.filter { $0.attribute == "22233333" } }
//            .bind {
//                print($0)
//            }
//            .disposed(by: disposeBag)
        
//        // MARK: - 過濾關聯
//
//        // 搜尋Entity attribute == "22233333"的Association
//        let filterIDEntity = Association.entity.filter(Entity.Columns.attribute == "22233333")
//
//        let request = Association.joining(required: filterIDEntity)
//
//        // 搜尋Associations id == "1"的EntityWithAssociationsIsOne
//        let entityRequest = Entity
//            .including(all: Entity.associaitons
//                .filter(Association.Columns.id == "1")
//                .forKey("associationsIsOne"))
//
//        try? GRDBManager.shared.dbWriter
//            .read { db in
//
//                let associations = try request.fetchAll(db)
//
//                let EntityInfo = try EntityWithAssociationsIsOne.fetchAll(db, entityRequest)
//
//                print(try Entity.fetchAll(db), associations, EntityInfo, separator: "\n")
//            }
    }
}

//// TODO: - 過濾關聯
//
//// https://github.com/groue/GRDB.swift/blob/master/Documentation/AssociationsBasics.md#filtering-associations
//struct EntityWithAssociationsIsOne: Decodable, FetchableRecord {
//    var entity: Entity
//    // 可以用來分類
//    var associationsIsOne: [Association]
//}
