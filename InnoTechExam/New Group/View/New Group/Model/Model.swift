//
//  Model.swift
//  InnoTechExam
//
//  Created by edisonlin on 2020/8/7.
//  Copyright © 2020 edison. All rights reserved.
//

import Foundation

struct DataModel:Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
