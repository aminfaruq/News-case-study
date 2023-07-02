//
//  Article.swift
//  News App
//
//  Created by Amin faruq on 18/06/23.
//

import Foundation

struct Article {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source {
    let id: String?
    let name: String?
}
