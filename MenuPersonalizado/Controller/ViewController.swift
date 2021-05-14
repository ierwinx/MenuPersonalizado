import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var vistaPrincipal: UIView!
    
    let vistaMenu = UIView()
    let tableView = UITableView()
    var heightCelda: CGFloat = 50
    let menus: Array<Menu> = [
        Menu(nombre: "Perfil", imagen: "Profile"),
        Menu(nombre: "Cambiar contraseña", imagen: "Password"),
        Menu(nombre: "Notificaciones", imagen: "Notification"),
        Menu(nombre: "Favoritos", imagen: "Favorite"),
        Menu(nombre: "Logout", imagen: "Logout")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: .main), forCellReuseIdentifier: "MenuTableViewCell")
        
        vistaPrincipal.isUserInteractionEnabled = true
        vistaPrincipal.addGestureRecognizer(gesto())
    }
    
    @IBAction func openMenu(_ sender: Any) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        vistaMenu.backgroundColor = UIColor.black
        let alto = self.view.frame.height / 3.2
        vistaMenu.frame = CGRect(x: 0.0, y: self.view.frame.maxY - 0.5, width: self.view.frame.width, height: alto)
        window.addSubview(vistaMenu)
        
        tableView.frame = CGRect(x: 0.0, y: self.view.frame.maxY, width: self.view.frame.width, height: alto)
        window.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            // se cambia de posicion sobre el eje Y para que paresca que sube el menu
            self.vistaMenu.frame = CGRect(x: 0.0, y: self.view.frame.maxY - alto - 0.5, width: self.view.frame.width, height: alto)
            self.tableView.frame = CGRect(x: 0, y: self.view.frame.maxY - alto, width: self.view.frame.width, height: alto)
        }, completion: nil)
        
        heightCelda = alto / CGFloat(self.menus.count)
    }
    
    // Habilita Gesto para un toque
    private func gesto() -> UITapGestureRecognizer {
        let unTap = UITapGestureRecognizer(target: self, action: #selector(clicVista))
        unTap.numberOfTapsRequired = 1
        unTap.numberOfTouchesRequired = 1
        return unTap
    }

    @objc func clicVista(gesture: UITapGestureRecognizer) {
        tableView.removeFromSuperview()
        vistaMenu.removeFromSuperview()
    }
    
    @IBAction func showNextMenu(_ sender: Any) {
        guard let controller = UIStoryboard(name: "Main2", bundle: .main).instantiateViewController(identifier: "ViewController2") as? ViewController2 else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightCelda
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        celda.setDatos(menu: self.menus[indexPath.row])
        return celda
    }
    
    
}
