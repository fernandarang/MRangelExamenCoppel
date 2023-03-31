//
//  Movie.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 30/01/23.
//

import Foundation

struct Movies : Codable {
    let page : Int
    var results : [Movie]?
    let totalPages, totalResults : Int
    
    enum CodingKeys : String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(page: Int, results: [Movie]?, totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
     
    init(){
        self.page = 0
        self.results = [Movie]()
        self.totalPages = 0
        self.totalResults = 0
    }
}

struct Movie : Codable{
    let adult : Bool?
    let backdropPath : String?
    let genereIDS : [Int]?
    let id : Int?
    let originalLanguage, originalTitle, overview, name : String?
    let popularity : Double?
    let posterPath, releaseDate, title, firstAirDate : String?
    let video : Bool?
    let voteAverage : Double?
    let voteCount : Int?
    
    enum CodingKeys : String, CodingKey{
        case adult
        case backdropPath = "backdrop_path"
        case genereIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case firstAirDate = "first_air_date"
    }
    
    init(adult: Bool?, backdropPath: String?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, genereIDS : [Int]?, name : String?, firstAirDate : String?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genereIDS = genereIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.name = name
        self.firstAirDate = firstAirDate
    }
    init (){
        self.adult = false
        self.backdropPath = ""
        self.genereIDS = [0]
        self.id = 0
        self.originalLanguage = ""
        self.originalTitle = ""
        self.overview = ""
        self.popularity = 0
        self.posterPath = ""
        self.releaseDate = ""
        self.title = ""
        self.video = false
        self.voteAverage = 0
        self.voteCount = 0
        self.name = ""
        self.firstAirDate = ""
    }
}
