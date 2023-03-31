//
//  MoviesViewController.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 03/02/23.
//

import UIKit

class MoviesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    @IBOutlet weak var menuSegment: UISegmentedControl!
    
    @IBAction func optionsSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            PopularMovies()
        }
        if sender.selectedSegmentIndex == 1{
            TopRated()
            
        }
        if sender.selectedSegmentIndex == 2{
            OnTv()
        }
        if sender.selectedSegmentIndex == 3{
            AiringToday()
        }
    }
    
    
    @IBAction func NavigationBar(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let passAction = UIAlertAction(title: "View Profile", style: .default) { (_) in
            self.performSegue(withIdentifier: "ProfileSegue", sender: self)
        }
        let destructiveAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(passAction)
        actionSheet.addAction(destructiveAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    
   
    let moviesViewModel = MovieViewModel()
    var movie = Movie()
    var movies = Movies()
    let imagen: String = "https://www.themoviedb.org/t/p/w1280/"
    var idMovie: Int? = nil
    var usuario =  User()
    var idSession : String? = nil
    var session = SessionModel()
    //var controller = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        
        self.MoviesCollectionView.register(UINib(nibName: "PelivulasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        PopularMovies()
        TopRated()
        OnTv()
        AiringToday()
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MoviesViewController{
    /*
    override func viewWillAppear(_ animated: Bool) {
        PopularMovies()
        //TopRated()
        // OnTv()
        // AiringToday()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    */
    func PopularMovies() {
        
        moviesViewModel.GetPopularMovies(movies: {requestdata, error in
            if let requestdata1 = requestdata {
                DispatchQueue.main.async {
                    self.movies = requestdata1
                    //print(requestdata?.results)
                    self.MoviesCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    func TopRated() {
        
        moviesViewModel.GetTopRated(movies: {requestdata, error in
            if let requestdata1 = requestdata{
                DispatchQueue.main.async {
                    self.movies = requestdata1
                   // print(requestdata?.results)
                    self.MoviesCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    func OnTv(){
        moviesViewModel.GetOnTv(movies: {requestdata, error in
            if let requestdata1 = requestdata{
                DispatchQueue.main.async {
                    self.movies = requestdata1
                   // print(requestdata?.results)
                    self.MoviesCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    func AiringToday(){
        moviesViewModel.GetAiringToday(movies: {requestdata, error in
            if let requestdata1 = requestdata{
                DispatchQueue.main.async {
                    self.movies = requestdata1
                    //print(requestdata?.results)
                    self.MoviesCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! PelivulasCollectionViewCell
        cell.layer.cornerRadius = 12
        
        
        if movies.results![indexPath.row].title == nil {
            cell.TitleLbl.text = movies.results![indexPath.row].name
        }else{
            cell.TitleLbl.text = movies.results![indexPath.row].title
        }
        if movies.results![indexPath.row].releaseDate == nil {
            cell.FechaEstrenoLbl.text = movies.results![indexPath.row].firstAirDate
        }else{
            cell.FechaEstrenoLbl.text = movies.results![indexPath.row].releaseDate
        }
        
        cell.PopularidadLbl.text = String(movies.results![indexPath.row].voteAverage!)
        cell.DescripcionLbl.text = movies.results![indexPath.row].overview
        
        cell.ImagenPelis.Imagen(URLAddress: "\(imagen)\(movies.results![indexPath.row].posterPath!)")
        cell.ImagenPelis.layer.cornerRadius = 12
        
        /*
        DispatchQueue.main.async{
            let urlImagen = self.imagen + self.movies.results![indexPath.row].posterPath!
            if let url = URL(string: urlImagen){
                do{
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async{
                        cell.ImagenPelis.image = UIImage(data: data)
                        cell.ImagenPelis.layer.cornerRadius = 12
                    }
                }catch let error {
                    print("Error al cargar la imagen " + error.localizedDescription)
                }
            }
        }
        */
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.idMovie = movies.results![indexPath.row].id
        self.performSegue(withIdentifier: "DetalleSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleSegue"{
            let detalleController = segue.destination as! DetalleTableViewController
            detalleController.idMovie = self.idMovie
        }
        
        if segue.identifier == "ProfileSegue"{
            let profileController = segue.destination as! FavoritosViewController
            profileController.idsession = self.idSession
            
        }
        
    }
}
extension UIImageView{
    func Imagen (URLAddress: String){
        guard let url = URL(string: URLAddress) else{
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url)else{return}
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
