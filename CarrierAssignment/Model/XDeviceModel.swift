//
//  XDeviceOutPutModel.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import Foundation
struct XDeviceModel: Decodable {
    let id: String?
    let serial_number: String?
    let model: String?
    let location: String?
    let date: String?
    let time: String?
    let weather: String?
    let thval: ThValModel?
}

struct ThValModel: Decodable {
    let temp: String?
    let hum: String?
    let alarm: String?
}
