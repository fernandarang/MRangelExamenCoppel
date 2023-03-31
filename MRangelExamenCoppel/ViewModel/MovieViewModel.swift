//
//  MovieViewModel.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 30/01/23.
//

import Foundation
class MovieViewModel {
    
    var movies = Movies()
    var movie = Movie()
    var requestToken : RequestTokenModel? = nil
    var usuario : User? = nil
    var sessionid : SessionModel? = nil
    var idMovie: Int? = nil
    var token = RequestTokenModel()
    var account = Account()
    
    //let vals = ("val", 1)
    
    func GetRequestToken(token : @escaping (RequestTokenModel?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=3a9809754553d44a507cfa5d7ebd832d")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else {
                //print("GetToken")
               // print(data)
                return
                
            }
            self.requestToken = try! decoder.decode(RequestTokenModel.self, from: data)
            token(self.requestToken,nil)

            if let error = error{
                token(nil, error)
            }
            
        }.resume()
    }
    
    
    func PostRequest(user: User , Logear: @escaping (RequestTokenModel?, Error?) -> Void){
        do{
            let decoder = JSONDecoder()
            let baseURL = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=3a9809754553d44a507cfa5d7ebd832d"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(user)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    //print("Login")
                    //print(data)
                    
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data)
                self.requestToken = try? decoder.decode(RequestTokenModel.self, from: data)
                Logear(self.requestToken, nil)
                
                
            }.resume()
        }
    }
    
    
    func PostSessionId(requestToken : RequestTokenModel ,Session : @escaping (SessionModel?, Error?) -> Void){
        do{
           let decoder = JSONDecoder()
           let baseURL =  "https://api.themoviedb.org/3/authentication/session/new?api_key=3a9809754553d44a507cfa5d7ebd832d"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(requestToken)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
               // print("DataSession \(String(describing: data))")
                //print(data)
                let json = try? JSONSerialization.jsonObject(with: data)
                self.sessionid = try? decoder.decode(SessionModel.self, from: data)
                Session(self.sessionid,nil)
            }.resume()
        }
    }
    
    
    
    func GetPopularMovies(movies : @escaping(Movies?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=3a9809754553d44a507cfa5d7ebd832d&language=en-US&page=1")
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else{
                return
            }
            self.movies = try! decoder.decode(Movies.self, from: data)
            movies(self.movies, nil)
            
            if let error = error {
                movies(nil,error)
            }
        }.resume()
    }
    
    func GetTopRated(movies : @escaping(Movies?, Error?) -> Void) {
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=3a9809754553d44a507cfa5d7ebd832d&language=en-US&page=1")
        urlSession.dataTask(with: url!) { data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else{
                return
            }
            self.movies = try! decoder.decode(Movies.self, from: data)
            movies(self.movies, nil)
            if let error = error {
                movies(nil, error)
            }
        }.resume()
    }
    
    func GetOnTv(movies : @escaping(Movies?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=3a9809754553d44a507cfa5d7ebd832d&language=en-US&page=1")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else {
                return
            }
            self.movies = try! decoder.decode(Movies.self, from: data)
            movies(self.movies, nil)
            if let error = error {
                movies(nil, error)
            }
        }.resume()
    }
    
    func GetAiringToday(movies: @escaping(Movies?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=3a9809754553d44a507cfa5d7ebd832d&language=en-US&page=1")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            guard let data = data else {
                return
            }
            self.movies = try! decoder.decode(Movies.self, from: data)
            movies(self.movies, nil)
            if let error = error {
                movies(nil, error)
            }
        }.resume()
    }
    
    func GetFavoriteMovies(idsession: String, movies :  @escaping (Movies?, Error?) -> Void){
        
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=3a9809754553d44a507cfa5d7ebd832d&session_id=\(idsession)&language=en-US&sort_by=created_at.asc&page=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        urlSession.dataTask(with: url!){ data, response, error in
            //print("Data \(String(describing: data))")
            guard let data = data else {
                return
            }
                self.movies = try! decoder.decode(Movies.self, from: data)
            movies(self.movies, nil)
            
            if let error = error {
                movies(nil, error)
            }
        }.resume()
        }
    
    
    
    func GetDetails(idMovie: Int, movie: @escaping(Movie?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=3a9809754553d44a507cfa5d7ebd832d&language=en-US")
        urlSession.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            self.movie = try! decoder.decode(Movie.self, from: data)
            movie(self.movie, nil)
            
            if let error = error {
                movie(nil, error)
            }
        }.resume()
    }
    
    func GetDetailsAccount(idsession: String, account: @escaping(Account?, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/account?api_key=3a9809754553d44a507cfa5d7ebd832d&session_id=\(idsession)")
        urlSession.dataTask(with: url!) { data, response, error in
            guard let data = data else {
                return
            }
            self.account = try! decoder.decode(Account.self, from: data)
            account(self.account, nil)
            
            if let error = error {
                account(nil, error)
            }
        }.resume()
    }
    
    
    }
    
     

