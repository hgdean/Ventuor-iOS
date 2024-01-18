//
//  VentuorListData.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/17/24.
//

import Foundation

struct VentuorListResult: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var template: String?
    var title: String?
    var ventuors: [VentuorData]?
}
struct VentuorList: Codable {
    var result: VentuorListResult?
    var error: ServerResponseError?
}

