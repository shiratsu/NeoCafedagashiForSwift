//
//  Web.swift
//  NeoCafeSagashiForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/06/22.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class Web: UIViewController,UIWebViewDelegate {

    @IBOutlet var webview: UIWebView!
    
    @IBOutlet var bannerview: GADBannerView!
    
    var serviceUrl:String?
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url:NSURL = NSURL(string: serviceUrl)
        let req = NSURLRequest(URL: url)
        webview.loadRequest(req)
        
        bannerview.adUnitID = "ca-app-pub-8789201169323567/1907251504";
        bannerview.rootViewController = self
        
        self.view.addSubview(bannerview);
        let request:GADRequest = GADRequest();
        bannerview.loadRequest(request)

        // Do any additional setup after loading the view.
    }
    func webViewDidStartLoad(webView: UIWebView!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        webview.goBack()
    }
    @IBAction func next(sender: AnyObject) {
        webview.goForward()
    }
    @IBAction func reload(sender: AnyObject) {
        webview.reload()
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
