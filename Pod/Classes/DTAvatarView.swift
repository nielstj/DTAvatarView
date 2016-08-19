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
open class DTAvatarView: UIView {
    
    
    @IBInspectable open weak var avaImage : UIImage? {
        didSet {
            profileImgView.image = avaImage
            initialLbl.isHidden = (avaImage != nil)
        }
    }
    @IBInspectable open weak var profileBGColor : UIColor? {
        didSet { profileContainer.backgroundColor = profileBGColor }
    }
    @IBInspectable open var initialLblFont : String? {
        didSet { self.updateInitialLbl() }
    }
    @IBInspectable open weak var initialColor : UIColor? {
        didSet { initialLbl.textColor = initialColor }
    }
    @IBInspectable var isProfileRounded : Bool = true
    
    
    
    
    @IBInspectable open var isNameHidden : Bool = false {
        didSet { self.updateAvaNameLbl() }
    }
    @IBInspectable open var avaName : String = "Anonymous"  {
        didSet {
            nameLbl.text = avaName
            initialLbl.text = getInitialFromName(avaName)
        }
    }
    @IBInspectable open var avaNameSize : CGFloat = 20 {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable open var avaNameFont : String? {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable open var avaNameColor : UIColor = UIColor.white {
        didSet { nameLbl.textColor = avaNameColor }
    }
    
    
    
    @IBInspectable open weak var topLeftIcon : UIImage? {
        didSet { topLeftIconImgView.image = topLeftIcon }
    }
    @IBInspectable open weak var topRightIcon : UIImage? {
        didSet { topRightIconImgView.image = topRightIcon }
    }
    @IBInspectable open weak var bottomLeftIcon : UIImage? {
        didSet { bottomLeftIconImgView.image = bottomLeftIcon }
    }
    @IBInspectable open weak var bottomRightIcon : UIImage? {
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
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        avaName = "Anonymous"
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DTAvatarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options : nil)[0] as! UIView
        return view
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    
    override open func draw(_ rect: CGRect) {
        
        let corner = min(profileContainer.frame.size.height, profileContainer.frame.size.width)
        let cornerRadius = isProfileRounded ? corner/2 : 0
        profileContainer.layer.cornerRadius = cornerRadius
        profileContainer.layer.masksToBounds = true
        updateInitialLbl()
        
    }
    
    
    fileprivate func updateAvaNameLbl() {
        if avaNameFont != nil {
            nameLbl.font = UIFont(name: avaNameFont!, size: CGFloat(avaNameSize))
        }
        else {
            nameLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(avaNameSize))
        }
        let height = isNameHidden ? 0 : avaNameSize
        nameLblHeightConstraint.constant = height
        self.layoutIfNeeded()
    }
    
    fileprivate func updateInitialLbl() {
        let corner = min(profileContainer.frame.size.height, profileContainer.frame.size.width) * 0.5
        if initialLblFont != nil {
            initialLbl.font = UIFont(name: initialLblFont!, size: CGFloat(corner))
        }
        else {
            initialLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(corner))
        }
    }
    
    fileprivate func getInitialFromName(_ name : String) -> String {
        var nameArr = name.components(separatedBy: " ")
        nameArr = nameArr.filter({ (word) -> Bool in
            return word.characters.count > 0
        })
        var initial = String(nameArr.first!.characters.first!)
        if nameArr.count > 1 { initial += String(nameArr.last!.characters.first!) }
        return initial
    }
}
