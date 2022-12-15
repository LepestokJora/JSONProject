//
//  JsonModel.swift
//  JSONProject
//
//  Created by Lepestok Jora on 14.12.2022.
//

import Foundation
//4. В текущем ДЗ необходимо создать модель для парсинга джейсона
struct ResponseData: Codable {
    let url: String?
    let title: String?
    let service_version: String?
    let media_type: String?
    let hdurl: String?
    let explanation: String?
    let date: String?
    let copyright: String?
}

