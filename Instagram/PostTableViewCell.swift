//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by AM16J0 on 2018/12/28.
//  Copyright © 2018年 masaya inamo. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentsTextField: UITextField!
    @IBOutlet weak var addcommentButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.commentsTextField.delegate = self
        
        //クリアボタンは常に設定
        commentsTextField.clearButtonMode = .always
        
        // 改行ボタンを「完了」に変更
        commentsTextField.returnKeyType = .done
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //コメント入力の表示
        var text = ""
        
        for comment in postData.comments  {
            text += comment
        }
        
        self.commentsLabel.text = text
        
        print("text: \(text)")
    }
    
    //コメント投稿後の挙動
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //入力文字の削除
        commentsTextField.text = ""
    }
    
    //textfieldタップ後の挙動
    func textFieldDidBeginEditing(_ textField:UITextField) {
        
        addcommentButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        // キーボードを隠す
        textfield.resignFirstResponder()
        return true
    }
}
