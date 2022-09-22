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
        
        do {
            // 4. Access the database
            try GRDBManager.shared.dbWriter.write { db in
                try Entity(attribute: "22233333").insert(db)
            }

            let entitys: [Entity] = try GRDBManager.shared.dbWriter.read { db in
                try Entity.fetchAll(db)
            }
            
            print(entitys)
        } catch {
            print(error)
        }
        
        GRDBManager.shared.entitys.EntitysOrderedByName()
            .bind {
                print($0)
            }
            .disposed(by: disposeBag)
        
        ValueObservation
            .tracking {
                try Entity.fetchAll($0)
            }
            .rx.observe(in: GRDBManager.shared.dbWriter)
            .bind {
                print($0, 123)
            }
            .disposed(by: disposeBag)
    }
}

