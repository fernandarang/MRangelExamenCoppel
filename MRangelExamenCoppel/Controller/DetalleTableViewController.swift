//
//  DetalleTableViewController.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 07/02/23.
//

import UIKit

class DetalleTableViewController: UITableViewController {
    
    var idMovie : Int? = nil
    var movie = Movie()
    var movies = [Movie]()
    let imagen: String = "https://www.themoviedb.org/t/p/w1280/"
    let moviesViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "DetalleTableViewCell", bundle: nil), forCellReuseIdentifier: "DetalleCell")
        
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadData() {
        
        moviesViewModel.GetDetails(idMovie: idMovie!, movie: { requestdata, error in
            if let requestdata1 = requestdata {
                DispatchQueue.main.async {
                    self.movie = requestdata1 
                    print(requestdata?.title)
                    self.tableView.reloadData()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
            
        })
            
        }
        
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return [movie].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleCell", for: indexPath) as! DetalleTableViewCell
        cell.TituloLbl.text = [movie][indexPath.row].title
        cell.FechaEstrenoLbl.text = [movie][indexPath.row].releaseDate
        cell.PuntosLbl.text = String([movie][indexPath.row].voteAverage!)
        cell.LenguaLbl.text = [movie][indexPath.row].originalLanguage
        cell.DescripcionLbl.text = [movie][indexPath.row].overview
        
        cell.ImagenMovie.ImagenDetalle(URLAddress: "\(imagen)\([movie][indexPath.row].posterPath!)")
        cell.ImagenMovie.layer.cornerRadius = 12
        /*
        DispatchQueue.global().async{
            let urlImagen = self.imagen + [self.movie][indexPath.row].posterPath!
        if let url = URL(string: urlImagen){
            do{
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.ImagenMovie.image = UIImage(data: data)
                    cell.ImagenMovie.layer.cornerRadius = 12
                }
            }catch let error {
                print("Error al cargar la imagen " + error.localizedDescription)
            }
        }
    }
*/
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImageView{
    func ImagenDetalle (URLAddress: String){
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
