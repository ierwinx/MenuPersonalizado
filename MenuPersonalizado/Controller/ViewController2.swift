import UIKit

class ViewController2: UIViewController {

    @IBOutlet var vistaPrincipal: UIView!
    
    let vistaMenu = UIView()
    let tableView = UITableView()
    let seccionPerfil = UIView()
    let imagenPerfil = UIImageView()
    
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
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        vistaPrincipal.isUserInteractionEnabled = true
        vistaPrincipal.addGestureRecognizer(gesto())
    }
    
    @IBAction func menuItemAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        vistaMenu.backgroundColor = UIColor.black
        let ancho = self.view.frame.width / 1.5
        vistaMenu.frame = CGRect(x: self.view.frame.minX - ancho, y: 0.0, width: ancho + 0.5, height: self.view.frame.height)
        window.addSubview(vistaMenu)
        
        
        seccionPerfil.backgroundColor = .white
        seccionPerfil.frame = CGRect(x: self.view.frame.minX - ancho, y: 0.0, width: ancho, height: 200)
        window.addSubview(seccionPerfil)
        
        imagenPerfil.frame = CGRect(x: self.view.frame.minX - ancho, y: 15, width: ancho, height: 193)
        imagenPerfil.image = UIImage(named: "364088")
        imagenPerfil.layer.cornerRadius = 30
        imagenPerfil.contentMode = .scaleAspectFit
        window.addSubview(imagenPerfil)
        
        tableView.frame = CGRect(x: self.view.frame.minX - ancho, y: 200, width: ancho, height: self.view.frame.height)
        window.addSubview(tableView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            // se cambia de posicion sobre el eje X para que paresca que sube el menu
            self.vistaMenu.frame = CGRect(x: self.view.frame.minX, y: 0.0, width: ancho + 0.5, height: self.view.frame.height)
            self.seccionPerfil.frame = CGRect(x: self.view.frame.minX, y: 0.0, width: ancho, height: 200)
            self.imagenPerfil.frame = CGRect(x: self.view.frame.minX, y: 15, width: ancho, height: 193)
            self.tableView.frame = CGRect(x: self.view.frame.minX, y: 200, width: ancho, height: self.view.frame.height)
        }, completion: nil)
        
        //heightCelda = alto / CGFloat(self.menus.count)
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
        seccionPerfil.removeFromSuperview()
        imagenPerfil.removeFromSuperview()
    }
    
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            self.clicVista(gesture: UITapGestureRecognizer())
            self.navigationController?.popViewController(animated: true)
        }
    }
    
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

