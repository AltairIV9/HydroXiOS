//
//  Dia.swift
//  HydroXiOS
//
//  Created by Walter Hugo on 30/11/22.
//

import Foundation
import RealmSwift

class Dia: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var dia: String = "0-0-0"
    @Persisted var quantidadeTomado: Int = 0
    @Persisted var neededNow: Float = 0
    @Persisted var currentRest: Int64 = 0
    
    convenience init(dia: String, quantidadeTomado: Int, neededNow: Float, currentRest: Int64){
        self.init()
        self.dia = dia
        self.quantidadeTomado = quantidadeTomado
        self.neededNow = neededNow
        self.currentRest = currentRest
    }
}
