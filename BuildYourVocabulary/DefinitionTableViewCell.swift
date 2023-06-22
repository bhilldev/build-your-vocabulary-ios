//
//  DefinitionTableViewCell.swift
import UIKit

class DefinitionTableViewCell: UITableViewCell {
    static let identifier = "DefinitionTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DefinitionTableViewCell", bundle: nil)
    }
   
    @IBOutlet var myDescriptor: UILabel!
    @IBOutlet var myDefinitionLabel: UILabel!
    
    public func configure(descriptor: String, definition: String) {
        myDescriptor.text = descriptor
        print("descriptor is: \(descriptor)")
        myDefinitionLabel.text = definition
        myDefinitionLabel.numberOfLines = 0
        myDefinitionLabel.lineBreakMode = .byWordWrapping
        myDefinitionLabel.textColor = K.TableViewColors.definitionCellTextColorHex
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
