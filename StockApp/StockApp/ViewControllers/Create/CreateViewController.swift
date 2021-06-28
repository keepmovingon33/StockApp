//
//  CreateViewController.swift
//  StockApp
//
//  Created by Sky on 5/20/21.
//

import UIKit

class CreateViewController: BaseViewController {

    @IBOutlet weak var createStockView: UIView!
    @IBOutlet weak var createStockViewImage: UIImageView!
    @IBOutlet weak var createStockViewLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var createRoomView: UIView!
    @IBOutlet weak var createRoomViewImage: UIImageView!
    @IBOutlet weak var createRoomViewLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupShadow()
        title = Constants.Create.title
        setupBackButton()
    }
    
    func configure() {
        createStockViewImage.image = UIImage(named: "createStock")
        createStockViewLabel.attributedText = NSAttributedString(string: Constants.Create.createStock, attributes: TextFormatting.purpleTitle)
        createRoomViewImage.image = UIImage(named: "createRoom")
        createRoomViewLabel.attributedText = NSAttributedString(string: Constants.Create.createRoom, attributes: TextFormatting.purpleTitle)
        orLabel.attributedText = NSAttributedString(string: Constants.Create.orText, attributes: TextFormatting.blackRegularTitle)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.createRoomButtonTapped(_:)))
        createRoomView.addGestureRecognizer(tap)
    }
    
    

    func setupShadow() {
        createStockView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        createRoomView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
    }
    
    @objc func createRoomButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        let vc = UIStoryboard.create.instantiateViewController(withIdentifier: "CreateRoomViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createStockButtonTapped(_ sender: Any) {
        guard let rooms = CurrentSession.instance.user?.ownRooms, rooms.count > 0 else {
            Helpers.showAlert(message: "Please create a room before create a stock")
            return
        }
        let vc = CreateStockViewController.create(rooms: rooms)
        navigationController?.pushViewController(vc, animated: true)
    }
}
