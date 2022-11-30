//
//  ContentView.swift
//  HydroXiOS
//
//  Created by Walter Hugo on 30/11/22.
//

import SwiftUI
import RealmSwift

struct MenuView: View {
    
    @State var config: Config
    @State var dia: Dia
    
    let realm = try! Realm()
    
    init(){
        let configs = realm.objects(Config.self)
        config = configs[0]
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let dias = realm.objects(Dia.self).filter("dia = '" + "\(day)" + "-" + "\(month)" + "-" + "\(year)" + "'")
        
        if(dias.count > 0){
            dia = dias[0]
        }else{
            dia = Dia(dia: "\(day)" + "-" + "\(month)" + "-" + "\(year)", quantidadeTomado: 0, neededNow: 0, currentRest: 0)
            try! realm.write {
                realm.add(dia)
            }
        }
        
        print(config)
        print(dia)
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10){
                Text("\(dia.quantidadeTomado)" + "/" + "\(config.quantidadeTotal)" + " ml")
                    .font(.system(size:33))
                
                
                Button(action: {
                    
                }, label: {
                    Text("\(config.tamanhoCopo)" + " ml")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                })
                
            }
            Button(action: {
                try! realm.write{
                    dia.quantidadeTomado += config.tamanhoCopo
                }
            }, label: {
                Text("Beber")
                    .font(.system(size:24))
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
