//
//  ContentView.swift
//  Proyecto
//
//  Created by Lambda on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var username: String = ""
    @State var info : String = ""
    @State var yesorno = false
    
    var body: some View {
        
        HStack {
           
            NavigationView {
                if yesorno == true{
                    Alertview {
                        ScrollView{
                            if bluetoothManager.equipo != "" {  Text(" Conectado a \(bluetoothManager.equipo)")}else{
                                Image(systemName: "xmark.icloud")
                                
                                Text("Aun no se ha connectado")
                                Text("Presione 🔵 para conectarse")
                            }
                           
      }
                        HStack{
                            Button(action: {
                                if #available(iOS 15, *){
                                    yesorno = false
                                 
                                }
                                
                            }, label: {
                                Text("Cancel")
                                    .bold()
                                    .foregroundColor(.red)
                            })
                            .padding()
                            Button(action:{
                               
                               
                            }, label: {Text("Connect")})
                            .foregroundColor(.white)
                            
                            
                        } }
                    
                } else{
                    VStack{
                       ScrollView{
                           Text("Dispositivo: ")
                               .font(.system(size: 13))
                               .bold()
                               .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                               
                            Text("\(bluetoothManager.equipo)")
                               .padding()
                           Text("SERVICIOS: ")
                               .font(.system(size: 13))
                               .bold()
                               .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                           Text("\(bluetoothManager.servicio)")
                               .padding()
                           Text("CARASTERISTICAS DESCUBIERTAS:")
                               .font(.system(size: 13))
                               .bold()
                               .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("\(bluetoothManager.status)")
                               .padding()
                           Text("CARASTERISTICAS REPUESTA:")
                               .font(.system(size: 13))
                               .bold()
                               .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                           Text("\(bluetoothManager.carasteristicas)")
                               .padding()
                              
                           Text("VALOR")
                               .font(.system(size: 13))
                               .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                           Text("\(bluetoothManager.Valor)")
                               .padding()
                          
                       } .frame(width: UIScreen.main.bounds.size.width/1.1)
                            .font(.system(size: 12))
                       
                        List(bluetoothManager.devices, id: \.self) { device in
                            
                            if device.name != nil{
                                
                                HStack {
                                    
                                    Button(action: {
                                        yesorno = true
                                         bluetoothManager.connect(to: device)
                                        
                                        
                                       
            
                                    }, label: {
                                        Text("🔵")
                                    })
                                    Text(device.name ?? "Unknown Device" )
                                
                                
                                   
                                }
                                
                                
                                
                            }
                        }
                        .navigationTitle("Hello IoT")
                        .onAppear {
                              bluetoothManager.startScanning2()
                        }
                        HStack{
                            Button(action: {
                                
                                yesorno = true
                                
                                
                            }, label: {
                                Text("⚙️")
                                    
                            })
                            Button("Scan"){
                                bluetoothManager.startScanning()}
                            .padding()
                            Button("Stop"){
                                bluetoothManager.fun()}
                            .padding()
                            Button(action:{
                                bluetoothManager.fun2()
                               
                            }, label: {Text("🧽")})
                        }
                            
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }}
                
                
            }.padding()
            
        }}
        
}
struct Alertview<Content: View>: View {
    
    let content:Content
    init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    var body: some View {
        
            VStack{
                Spacer()
               
                content
                    .padding()
                Divider()
                }
            .frame(width: UIScreen.main.bounds.size.width/1.1)
            .background(Color.gray)
            .cornerRadius(7)
            .padding()
        }
}
#Preview {
    ContentView()
}
