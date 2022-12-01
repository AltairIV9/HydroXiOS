//
//  ContentView.swift
//  HydroXiOS
//
//  Created by Walter Hugo on 30/11/22.
//

import SwiftUI
import RealmSwift
import UserNotifications

class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) {
            (success, error) in
            if let error = error{
                print("ERROR: \(error)")
                    
            }else{
                print("Success")
            }
        }
    }
    
    func scheduleNotification(time: Double){
        let content = UNMutableNotificationContent()
        content.title = "HydroX"
        content.subtitle = "Beba Água!"
        content.sound = .default
        content.badge = 1
        
        //time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

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
            
            let startTimeAmanha = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            NotificationManager.instance.scheduleNotification(time: Double(startTimeAmanha.timeIntervalSinceNow))
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
                let stopTime = Calendar.current.date(bySettingHour: config.stopTime, minute: 0, second: 0, of: Date())!
                
                try! realm.write{
                    dia.quantidadeTomado += config.tamanhoCopo
                    dia.neededNow = Float((config.quantidadeTotal-dia.quantidadeTomado)/config.tamanhoCopo)
                    dia.currentRest = Float(stopTime.timeIntervalSinceNow)/dia.neededNow
                }
                dia = Dia(dia: dia.dia, quantidadeTomado: dia.quantidadeTomado, neededNow: dia.neededNow, currentRest: dia.currentRest)

                if(dia.neededNow > 0 && dia.currentRest > 0){
                    NotificationManager.instance.scheduleNotification(time: Double(dia.currentRest))
                }
                
            }, label: {
                Text("Beber")
                    .font(.system(size:24))
            })
            Button(action: {
                
            }, label: {
                Text("Fazer nada")
            })
            Button(action: {
                try! realm.write{
                    config.startTime = 8
                    config.stopTime = 20
                }
            }, label: {
                Text("Mudar config")
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
