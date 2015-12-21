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
        didSet { profileContainer.backgroundColor = profileBGColor }
    }
    @IBInspectable var initialLblFont : String? {
        didSet { self.updateInitialLbl() }
    }
    @IBInspectable weak var initialColor : UIColor? {
        didSet { initialLbl.textColor = initialColor }
    }
    @IBInspectable var isProfileRounded : Bool = true
    
    
    
    
    @IBInspectable var isNameHidden : Bool = false {
        didSet { self.updateAvaNameLbl() }
    }
    @IBInspectable var avaName : String? {
        didSet {
            let name = avaName != nil ? avaName : "Anonymous"
            nameLbl.text = name
            initialLbl.text = getInitialFromName(name!)
        }
    }
    @IBInspectable var avaNameSize : CGFloat = 20 {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable var avaNameFont : String? {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable var avaNameColor : UIColor = UIColor.whiteColor() {
        didSet { nameLbl.textColor = avaNameColor }
    }
    
    
    
    @IBInspectable weak var topLeftIcon : UIImage? {
        didSet { topLeftIconImgView.image = topLeftIcon }
    }
    @IBInspectable weak var topRightIcon : UIImage? {
        didSet { topRightIconImgView.image = topRightIcon }
    }
    @IBInspectable weak var bottomLeftIcon : UIImage? {
        didSet { bottomLeftIconImgView.image = bottomLeftIcon }
    }
    @IBInspectable weak var bottomRightIcon : UIImage? {
        didSet { bottomRightIconImgView.image = bottomRightIcon }
    }
    
    
    
    
    
    
    @IBOutlet weak var profileContainer : UIView!
    
    @IBOutlet weak var initialLbl : UILabel!
    @IBOutlet weak var profileImgView : UIImageView!
    @IBOutlet weak var topLeftIconImgView : UIImageView!
    @IBOutlet weak var topRightIconImgView : UIImageView!
    @IBOutlet weak var bottomLeftIconImgView : UIImageView!
    @IBOutlet weak var bottomRightIconImgView : UIImageView!
    
    @IBOutlet weak var nameLblHeightConstraint : NSLayoutConstraint!
    
    
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
        
        let corner = min(profileContainer.frame.size.height, profileContainer.frame.size.width)
        let cornerRadius = isProfileRounded ? corner/2 : 0
        profileContainer.layer.cornerRadius = cornerRadius
        profileContainer.layer.masksToBounds = true
        updateInitialLbl()
        
    }
    
    
    private func updateAvaNameLbl() {
        if avaNameFont != nil {
            nameLbl.font = UIFont(name: avaNameFont!, size: CGFloat(avaNameSize))
        }
        else {
            nameLbl.font = UIFont.boldSystemFontOfSize(CGFloat(avaNameSize))
        }
        let height = isNameHidden ? 0 : avaNameSize
        nameLblHeightConstraint.constant = height
        self.layoutIfNeeded()
    }
    
    private func updateInitialLbl() {
        let corner = min(profileContainer.frame.size.height, profileContainer.frame.size.width) * 0.5
        if initialLblFont != nil {
            initialLbl.font = UIFont(name: initialLblFont!, size: CGFloat(corner))
        }
        else {
            initialLbl.font = UIFont.boldSystemFontOfSize(CGFloat(corner))
        }
    }
    
    private func getInitialFromName(name : String) -> String {
        var nameArr = name.componentsSeparatedByString(" ")
        nameArr = nameArr.filter({ (word) -> Bool in
            return word.characters.count > 0
        })
        var initial = String(nameArr.first!.characters.first!)
        if nameArr.count > 1 { initial += String(nameArr.last!.characters.first!) }
        return initial
    }
}
