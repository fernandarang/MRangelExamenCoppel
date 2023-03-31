//
//  ViewController.swift
//  MRangelExamenCoppel
//
//  Created by MacBookMBA5 on 30/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var invalidoLbl: UILabel!
    
    
    
    var usuario : User? = nil
    var token = RequestTokenModel()
    let movieViewModel = MovieViewModel()
    var sesion = SessionModel()
    var idsession : String? = nil
    var movies = Movies()
    var sessionId : String? = nil
    var perfil = FavoritosViewController()
    
    @IBAction func loginBtn(_ sender: UIButton) {
        // Request Token ------------------------------------------------------------------------------------
        let Username = usernameField.text!
        let Password = passwordField.text!
        
        movieViewModel.GetRequestToken(token:  { requestdata, error in
            if let requestdata1 = requestdata{
                DispatchQueue.main.async {
                    self.token = requestdata1
                    print("token1")
                    print(requestdata?.requestToken)
                    //POSTRequest
                    self.usuario = User(username: Username, password: Password, requestToken: self.token.requestToken)
                    self.Login()
                }
            }
            if let error1 = error {
                print(error1.localizedDescription)
            }
            
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        invalidoLbl.isHidden = true
        // Do any additional setup after loading the view.
    
            }
    
    func Login(){
        // Login with username and password -----------------------------------------------------------------
                movieViewModel.PostRequest(user: usuario!, Logear: { requestdata, error in
                    
                    if let logindata = requestdata{
                        DispatchQueue.main.async {
                            self.token = logindata
                            print("token2")
                            print(requestdata?.requestToken)
                            self.invalidoLbl.isHidden = true
                            self.Session()
                        }
                    }else{
                        self.invalidoLbl.isHidden = false
                    }
                    
                    if let error1 = error{
                        print(error1.localizedDescription)
                    }
                })
            }
    
    func Session(){
        // SessionId ----------------------------------------------------------------------------------------
        movieViewModel.PostSessionId(requestToken: token, Session: { requestdata, error in
            
            if let sessiondata = requestdata {
                DispatchQueue.main.async {
                    self.sesion = sessiondata
                    print("SessionId")
                    self.sessionId = requestdata?.sessionId
                    print(self.sessionId)
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                }
            }
            if let error1 = error{
                print(error1.localizedDescription)
            }
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue"{
            let movieController = segue.destination as! MoviesViewController
            movieController.idSession = self.sessionId
        }
    }

}
    




