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
public class DTAvatarView: UIView {
    
    
    @IBInspectable public weak var avaImage : UIImage? {
        didSet {
            profileImgView.image = avaImage
            initialLbl.isHidden = (avaImage != nil)
        }
    }
    @IBInspectable public weak var profileBGColor : UIColor? {
        didSet { profileContainer.backgroundColor = profileBGColor }
    }
    @IBInspectable public var initialLblFont : String? {
        didSet { self.updateInitialLbl() }
    }
    @IBInspectable public weak var initialColor : UIColor? {
        didSet { initialLbl.textColor = initialColor }
    }
    @IBInspectable var isProfileRounded : Bool = true
    
    
    
    
    @IBInspectable public var isNameHidden : Bool = false {
        didSet { self.updateAvaNameLbl() }
    }
    @IBInspectable public var avaName : String = "Anonymous"  {
        didSet {
            nameLbl.text = avaName
            initialLbl.text = getInitialFromName(avaName)
        }
    }
    @IBInspectable public var avaNameSize : CGFloat = 20 {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable public var avaNameFont : String? {
        didSet { updateAvaNameLbl() }
    }
    @IBInspectable public var avaNameColor : UIColor = UIColor.white() {
        didSet { nameLbl.textColor = avaNameColor }
    }
    
    
    
    @IBInspectable public weak var topLeftIcon : UIImage? {
        didSet { topLeftIconImgView.image = topLeftIcon }
    }
    @IBInspectable public weak var topRightIcon : UIImage? {
        didSet { topRightIconImgView.image = topRightIcon }
    }
    @IBInspectable public weak var bottomLeftIcon : UIImage? {
        didSet { bottomLeftIconImgView.image = bottomLeftIcon }
    }
    @IBInspectable public weak var bottomRightIcon : UIImage? {
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
        
        let bundle = Bundle(for: self.dynamicType)
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

    
    override public func draw(_ rect: CGRect) {
        
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
            nameLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(avaNameSize))
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
            initialLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(corner))
        }
    }
    
    private func getInitialFromName(_ name : String) -> String {
        var nameArr = name.components(separatedBy: " ")
        nameArr = nameArr.filter({ (word) -> Bool in
            return word.characters.count > 0
        })
        var initial = String(nameArr.first!.characters.first!)
        if nameArr.count > 1 { initial += String(nameArr.last!.characters.first!) }
        return initial
    }
}
