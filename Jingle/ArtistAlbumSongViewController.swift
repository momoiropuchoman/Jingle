//
//  ArtistAlbumSongViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/09.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistAlbumSongViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var songTable: UITableView!

    var songNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = MusicInfo.selectedAlbum
        
        let query = MPMediaQuery.songsQuery()
        let predicate = MPMediaPropertyPredicate(value: MusicInfo.selectedArtist, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.EqualTo)
        query.addFilterPredicate(predicate)
        let predicate2 = MPMediaPropertyPredicate(value: MusicInfo.selectedAlbum, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.EqualTo)
        query.addFilterPredicate(predicate2)
        for collection in query.collections! {
            let song = collection.representativeItem!.title ?? "不明"
            songNames.append(song)
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songNames.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistAlbumSongCell", forIndexPath: indexPath)
        if(indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel!.textAlignment = NSTextAlignment.Center
            cell.textLabel!.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = String(songNames.count) + "曲"
        } else {
            cell.textLabel!.textAlignment = NSTextAlignment.Left
            cell.textLabel!.font = UIFont.systemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = songNames[indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row != 0) {
            let query = MPMediaQuery.songsQuery()
            let predicate = MPMediaPropertyPredicate(value: MusicInfo.selectedArtist, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.EqualTo)
            query.addFilterPredicate(predicate)
            let predicate2 = MPMediaPropertyPredicate(value: MusicInfo.selectedAlbum, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.EqualTo)
            query.addFilterPredicate(predicate2)
            let predicate3 = MPMediaPropertyPredicate(value: songNames[indexPath.row - 1], forProperty: MPMediaItemPropertyTitle, comparisonType: MPMediaPredicateComparison.EqualTo)
            query.addFilterPredicate(predicate3)
            MusicInfo.player.setQueueWithQuery(query)
            MusicInfo.player.play()
        
            songTable.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(indexPath.row == 0) {
            return nil
        } else {
            return indexPath
        }
    }

    
    
}
