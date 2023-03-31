//
//  FavoritosViewController.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 07/02/23.
//

import UIKit

class FavoritosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    
    @IBOutlet weak var FavoritosCollectionView: UICollectionView!
    
    
    var moviesViewModel = MovieViewModel()
    var idMovie : Int? = nil
    var movies = Movies()
    var account = Account()
    let imagen: String = "https://www.themoviedb.org/t/p/w1280/"
    var idsession : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritosCollectionView.delegate = self
        FavoritosCollectionView.dataSource = self
        
        self.FavoritosCollectionView.register(UINib(nibName: "PelivulasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        
        favoritos()
        usuario()
        // Do any additional setup after loading the view.
    }
    
    func favoritos(){
        moviesViewModel.GetFavoriteMovies(idsession: idsession!, movies: { requestdata, error in
            if let requestdata1 = requestdata {
                DispatchQueue.main.async {
                    self.movies = requestdata1
                    print(requestdata?.results)
                    self.FavoritosCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
            
        })
    }
    
    func usuario(){
        moviesViewModel.GetDetailsAccount(idsession: idsession!, account: {requestdata, error in
            if let requestdata1 = requestdata {
                DispatchQueue.main.async {
                    self.account = requestdata1
                    print(requestdata?.username)
                    self.userNameLbl.text = "@\(requestdata!.username)"
                    self.FavoritosCollectionView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
        })
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

extension FavoritosViewController{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! PelivulasCollectionViewCell
        cell.layer.cornerRadius = 12
        
        cell.TitleLbl.text = movies.results![indexPath.row].title
        cell.FechaEstrenoLbl.text = movies.results![indexPath.row].releaseDate
        cell.PopularidadLbl.text = String(movies.results![indexPath.row].voteAverage!)
        cell.DescripcionLbl.text = movies.results![indexPath.row].overview
        
        cell.ImagenPelis.ImagenFavoritos(URLAddress: "\(imagen)\(movies.results![indexPath.row].posterPath!)")
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
        self.performSegue(withIdentifier: "DetalleFavSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleFavSegue"{
            let detalleController = segue.destination as! DetalleTableViewController
            detalleController.idMovie = self.idMovie
        }
    }
}

extension UIImageView{
    func ImagenFavoritos (URLAddress: String){
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
