//
//  AppConstants.swift
//  CarrierAssignment
//
//  Created by Apple on 05/03/22.
//

import Foundation
import UIKit

let BASE_URL = "https://api.carrier.com/api/v4/"
let LOGIN_API = "auth/login"
let X_DEVICE_API = "location/12456/device"

let CONTENT_TYPE_VALUE = "application/json; charset=utf-8"
let CONTENT_TYPE = "Content-Type"
let HTTP_METHOD_POST = "POST"
let HTTP_METHOD_GET = "GET"
let AUTHORIZATION = "Authorization"

let CarrierAssignment_SharedInstance = UIApplication.shared.delegate as! AppDelegate
