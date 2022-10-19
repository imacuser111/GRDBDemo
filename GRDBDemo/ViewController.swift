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
//                    try Entity(attribute: "22233333").insert(db)
//                }
//
//            try GRDBManager.shared.dbWriter
//                .write { db in
//                    try Association(entityID: 3).insert(db)
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
        
//        // 讀取所有entitys
//        GRDBManager.shared.entitys
//            .fetchAll()
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
//                let associationInfo = try AssociationInfo.fetchAll(db, request)
//
//                // po 第一個entity的associaitons
//                print(associationInfo.first?.entity.associaitons, 111333)
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
    }
}

