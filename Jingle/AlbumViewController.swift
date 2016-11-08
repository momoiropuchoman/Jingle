//
//  AlbumViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/08.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import Foundation
import MediaPlayer

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var albumTable: UITableView!
    @IBOutlet weak var songLabel: UILabel!
    
    var albumNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)

        
        let query = MPMediaQuery.albumsQuery()
        for collection in query.collections! {
            let albumName = collection.representativeItem!.albumTitle ?? "不明"
            albumNames.append(albumName)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("playing")
        self.presentViewController(nextView!, animated: true, completion: nil)
        
    }


    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath)
        cell.textLabel!.text = albumNames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}