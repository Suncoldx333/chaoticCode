//
//  BlueTooth.swift
//  JSCallOC
//
//  Created by 11111 on 2017/8/18.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import CoreBluetooth

class BlueTooth: UIViewController {

    //MARK: - View life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var manager : CBCentralManager!
    var peripherals : [CBPeripheral]!
    
    lazy var nameLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 45))
        inner.textColor = ColorMethodho(hexValue: 0x404040)
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        inner.textAlignment = .center
        inner.font = UIFont.systemFont(ofSize: 15)
        return inner
    }()
    
    lazy var idLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 50, width: ScreenWidth, height: 45))
        inner.textColor = ColorMethodho(hexValue: 0x404040)
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        inner.textAlignment = .center
        inner.font = UIFont.systemFont(ofSize: 15)
        return inner
    }()
    
    lazy var valueLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: ScreenWidth, height: 45))
        inner.textColor = ColorMethodho(hexValue: 0x404040)
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        inner.textAlignment = .center
        inner.font = UIFont.systemFont(ofSize: 15)
        return inner
    }()

    
    //MARK: - Initialize
    fileprivate func initData() {
        manager = CBCentralManager.init(delegate: self, queue: nil)
        peripherals = [CBPeripheral]()
    }
    
    fileprivate func initUI() {
        view.backgroundColor = ColorMethodho(hexValue: 0xe6e6e6)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(valueLabel)
    }
    
    func beginSearch() {
        manager.scanForPeripherals(withServices: nil, options: nil)
    }

}

extension BlueTooth : CBCentralManagerDelegate,CBPeripheralDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            printWithTime("CBManagerStateUnknown")
            break
        case .resetting:
            printWithTime("CBCentralManagerStateResetting")
            break
        case .unsupported:
            printWithTime("CBCentralManagerStateUnsupported")
            break
        case .unauthorized:
            printWithTime("CBCentralManagerStateUnauthorized")
            break
        case .poweredOff:
            printWithTime("CBCentralManagerStatePoweredOff")
            break
        case .poweredOn:
            printWithTime("CBCentralManagerStatePoweredOn")
            self.beginSearch()
            break

        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        
        manager.stopScan()
        manager.connect(peripheral, options: nil)
        printWithTime("链接外设：\(peripheral.description)")
    }
    
    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral) {
        printWithTime("已经连接到：\(peripheral.description)")
        idLabel.text = peripheral.identifier.uuidString
        nameLabel.text = peripheral.name
        peripheral.delegate = self
        central.stopScan()
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard let services = peripheral.services else {
            return
        }
        
        for service : CBService in services {
            printWithTime(service.uuid)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if (error != nil) {
            printWithTime("发生错误")
            return
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic : CBCharacteristic in characteristics {
            printWithTime("uuid = \(characteristic.uuid)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            printWithTime("失败")
            return
        }
        
        guard let valueData = characteristic.value else {
            return
        }
        let valueStr = String.init(data: valueData, encoding: .utf8) ?? "none"
        valueLabel.text = valueStr
        printWithTime("value = \(valueStr)")
    }
}
