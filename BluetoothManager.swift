//
//  BluetoothManager.swift
//  Proyecto
//
//  Created by Lambda on 6/14/24.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var devices: [CBPeripheral] = []
    @Published var equipo: String = ""
    @Published var carasteristicas: Array = []
    @Published var status: Array = []
    @Published var servicio: Array = []
    @Published var Valor: Array = []
    @Published var cantidad: Array = []
    
  
    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    

    override init() {
        super.init()
       
        if !(servicio.isEmpty == false) {
            
            print("There are no objects")
        }
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager.stopScan()
    }
    func frombase64(word:String)->String {
        let base62Decoded = Data(base64Encoded: word)!
        let decodedString = String(data:base62Decoded, encoding: .utf8)!
        
        return  decodedString
    }
    func fun (){
        centralManager.stopScan()
        print("Escaneo detenido ")
    }
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
       
    }
    func startScanning2() {
      
        centralManager.stopScan()
    }

    func connect(to peripheral: CBPeripheral) {
        centralManager.stopScan()
        connectedPeripheral = peripheral
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
        
        
    }

    // CBCentralManagerDelegate methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning2()
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !devices.contains(peripheral) {
            devices.append(peripheral)
            if peripheral.name != nil{
                cantidad.append(peripheral.name ?? "")
            }
            
           
           
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "unknown device")")
       equipo = (peripheral.name ?? "unknown device")
       
        peripheral.discoverServices(nil)
        
       
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                print("Discovered service: \(service)")
                
                servicio.append(service)
                peripheral.discoverCharacteristics(nil, for: service)
             
               
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Discovered characteristic: \(characteristic)")
                if characteristic.properties.contains(.read) {
                    peripheral.readValue(for: characteristic)
                    status.append(characteristics)
                 
                }
                if characteristic.properties.contains(.write) {
                    // Example: Write a value to the characteristic
                    let value = "Hello IoT".data(using: .utf8)!
                    peripheral.writeValue(value, for: characteristic, type: .withResponse)
                    carasteristicas.append(characteristic)
                
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
           let  deco = value.base64EncodedString()
            let some = frombase64(word: deco)
            
            Valor.append(some)
            
            print("Received value: \(some)")
        }
    }
}
