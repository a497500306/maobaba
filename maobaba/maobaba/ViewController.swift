//
//  ViewController.swift
//  maobaba
//
//  Created by 毛立 on 2019/11/29.
//  Copyright © 2019 毛立. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        button.setTitle("点击下载", for: UIControl.State.normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(self.clickButton), for: UIControl.Event.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        
        
    }

    @objc private func clickButton() {
        let url = "ed2k://|file|%E5%BF%AB%E9%80%92%E5%91%98.1080p.HD%E4%B8%AD%E8%8B%B1%E5%8F%8C%E5%AD%97.mp4|1082759356|3F6803C44ADB520F6A37C70C06F3CB23|h=M2WW7XZSRIOFBJV4Z2ORHQFUK32TUN63|/"
        
        Alamofire.download(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) { (url, request) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in

            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("123123")

            print(fileURL)

            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])

        }
        .downloadProgress(closure: { (progress) in
            print(progress)
        })
        .responseJSON { (response) in
             switch response.result {

                 case .success:
                     print("success")
                 case .failure:
                     //意外中断后在此处处理下载完成的部分
                     print("意外中断后在此处处理下载完成的部分")
                    break
                 default:
                    print("failed")
                    break
                 }
        }
        .response { (response) in
                print("完成下载：\(response)")
        }
    }

}

