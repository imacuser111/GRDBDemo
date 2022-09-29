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
        
//        var e = Entity()
        
//        e.attribute = "123"
        
//        try? DBManager.updateEntity(e)
        
//        print(DBManager.entity)
        
        
        // notification(當Entity改變時)
        let observation = DatabaseRegionObservation(tracking: Entity.all())
        
        observation.rx
            .changes(in: GRDBManager.shared.dbWriter)
            .bind {
                print($0, 1111111222223333)
            }
            .disposed(by: disposeBag)
        
        do {
            // 4. Access the database
            try GRDBManager.shared.dbWriter
                .write { db in
                    try Entity(attribute: "22233333").insert(db)
                }

            try GRDBManager.shared.dbWriter
                .write { db in
                    try Association(entityID: 3).insert(db)
                }
            
        } catch {
            print(error)
        }
        
//        GRDBManager.shared.entitys
//            .rx_deleteOne(Int64(2))
//            .asObservable()
//            .materialize()
//            .bind {
//                print($0)
//            }
//            .disposed(by: disposeBag)
        
//        GRDBManager.shared.entitys
//            .fetchAll()
//            .bind {
//                print($0, 1111111)
//            }
//            .disposed(by: disposeBag)
//
//        GRDBManager.shared.associations
//            .fetchAll()
//            .bind {
//                print($0, 22222)
//            }
//            .disposed(by: disposeBag)
//
//        try? GRDBManager.shared.dbWriter
//            .read { db in
//                let request = Association.including(optional: Association.entity)
//                let associationInfo = try AssociationInfo.fetchAll(db, request)
//
//                print(associationInfo, 111333)
//            }
    }
}

