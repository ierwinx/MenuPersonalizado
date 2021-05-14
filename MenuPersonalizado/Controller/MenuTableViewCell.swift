import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconoMenu: UIImageView!
    @IBOutlet weak var tituloMenu: UILabel!

    func setDatos(menu: Menu) -> Void {
        iconoMenu.image = UIImage(named: menu.imagen)
        tituloMenu.text = menu.nombre
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
