//
//  ContentView.swift
//  HydroXiOS
//
//  Created by Walter Hugo on 30/11/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State var quantidadeTotal: String = "0/0 ml"
    @State var tamanhoCopo: String = "0 ml"
        
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10){
                Text(quantidadeTotal)
                    .font(.system(size:33))
                
                
                Button(action: {
                    
                }, label: {
                    Text(tamanhoCopo)
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                })
                
            }
            Button(action: {
                
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
        ContentView()
    }
}
