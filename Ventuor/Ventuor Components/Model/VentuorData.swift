//
//  VentuorModel.swift
//  Ventuor
//
//  Created by H Sam Dean on 1/11/24.
//

import Foundation

struct VentuorResult: Codable {
    var resultCode: Int?
    var resultMessage: String?
    var template: String?
    var ventuor: VentuorData?
}
struct Ventuor: Codable {
    var result: VentuorResult?
    var error: ServerResponseError?
}
struct VentuorData: Codable {
    var owner: Bool?
    var ventuorKey: String?
    var ventuorName: String?
    var title: String?
    var subTitle1: String?
    var subTitle2: String?
    var icon: String?
    var distance: String?
    var status: String?
    var timeframeStatus: String?
    var timeframeStatusMessage: String?
    var rating: Int?
    var statusMessage: String?
    var hoursSplMsg: String?
    var save: Bool?
    var checkIn: Bool?
    var follow: Bool?
    var share: Bool?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var map: String?
    var walk: Bool?
    var drive: Bool?
    var phone: String?
    var countrycode: String?
    var call: Bool?
    var showHours: Bool?
    var hours: String?
    var menu: Bool?
    var webSiteTitle: String?
    var webSiteUrl: String?
    var message: Bool?
    var addPhoto: Bool?
    var review: Bool?
    var report: Bool?
    var pages: [PageVO]?
    var photos: [ImageFileVO]?
    var bulletin: String?
    var closedMessage: String?
    var doorStep: String?
    var parking: String?
    var isDoorStep: Bool?
    var isParking: Bool?
    var departmentHours: [DepartmentHoursJSON]?
    var twitterHandle: String?
    var youtubeChannel: String?
    var facebook: String?
    var appName: String?
    var appUrl: String?
    var appStoreUrl: String?
    var lastModified: String?
    var liveMode: Bool?
    var displayOrder: Int?
    var payments: String?
}

struct PageVO: Codable {
    var ventuorKey: String?
    var pageId: String?
    var title: String?
    var detail: String?
}

struct ImageFileVO: Codable {
    var ventuorKey: String?
    var fileName: String?
    var fileType: String?
    var caption: String?
}

struct DepartmentHoursJSON: Codable {
    var name: String?
    var status: String?
    var statusMessage: String?
    var content: String?
}

struct DepartmentHours: Identifiable {
    var id: Int
    var deptHours: DepartmentHoursJSON? = nil
}

struct Pages: Identifiable {
    var id: Int
    var page: PageVO? = nil
}
