//
//  XDeviceOutPutModel.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import Foundation
struct XDeviceModel {
    let id: Int?
    let serial_number: String?
    let model: String?
    let location: String?
    let date: String?
    let time: String?
    let weather: String?
    let thVal: ThValModel?
    
    enum CodingKey: String,Decodable {
        case id,serial_number,model,location,date,time,weather,thVal
    }
}

struct ThValModel {
    let temp: String?
    let hum: String?
    let alarm: String?
    
    enum CodingKey: String,Decodable {
        case temp,hum,alarm
    }
}
