//
//  DTAvatarView.swift
//  Pods
//
//  Created by Daniel Tjuatja on 14/12/15.
//
//

import Foundation
import UIKit

@IBDesignable
class DTAvatarView: UIView {
    
    
    @IBInspectable weak var avaImage : UIImage? {
        didSet {
            profileImgView.image = avaImage
            initialLbl.hidden = (avaImage != nil)
        }
    }
    @IBInspectable weak var profileBGColor : UIColor? {
        didSet {
            profileContainer.backgroundColor = profileBGColor
        }
    }
    @IBInspectable var isProfileRounded : Bool = true
    
    
    @IBInspectable var isNameHidden : Bool = false {
        didSet {
            let center = isNameHidden ? 0 : nameLbl.frame.size.height
            nameLbl.hidden = isNameHidden
            imgCenterConstraint.constant = center
            self.layoutIfNeeded()
        }
    }
    
    
    @IBInspectable var avaName : String? {
        didSet {
            let name = avaName != nil ? avaName : "Anonymous"
            nameLbl.text = name
            initialLbl.text = getInitialFromName(name!)
        }
    }
    
    
    @IBOutlet weak var profileContainer : UIView!
    
    @IBOutlet weak var initialLbl : UILabel!
    @IBOutlet weak var profileImgView : UIImageView!
    @IBOutlet weak var topLeftIcon : UIImageView!
    @IBOutlet weak var topRIghtIcon : UIImageView!
    @IBOutlet weak var bottomLeftIcon : UIImageView!
    @IBOutlet weak var bottomRightIcon : UIImageView!
    
    @IBOutlet weak var imgCenterConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var nameLbl : UILabel!
    
    
    
    
    
    var view : UIView!
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "DTAvatarView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options : nil)[0] as! UIView
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    
    override func drawRect(rect: CGRect) {
        
        let corner = max(profileContainer.frame.size.height, profileContainer.frame.size.width)
        let cornerRadius = isProfileRounded ? corner/2 : 0
        profileContainer.layer.cornerRadius = cornerRadius
        profileContainer.layer.masksToBounds = true
    }
    
    private func getInitialFromName(name : String) -> String {
        let nameArr = name.componentsSeparatedByString(" ")
        var initial = String(nameArr.first!.characters.first!)
        if nameArr.count > 1 { initial += String(nameArr.last!.characters.first!) }
        return initial
    }
}
