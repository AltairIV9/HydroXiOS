//
//  Config.swift
//  HydroXiOS
//
//  Created by Walter Hugo on 30/11/22.
//

import Foundation
import RealmSwift

class Config: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var tamanhoCopo: Int = 300
    @Persisted var quantidadeTotal: Int = 3000
    @Persisted var startTime: Int = 8
    @Persisted var stopTime: Int = 23
    
    convenience init(tamanhoCopo: Int, quantidadeTotal: Int, startTime: Int, stopTime: Int) {
        self.init()
        self.tamanhoCopo = tamanhoCopo
        self.quantidadeTotal = quantidadeTotal
        self.startTime = startTime
        self.stopTime = stopTime
    }
}
