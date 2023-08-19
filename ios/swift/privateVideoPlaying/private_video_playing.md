# Private Video Playing

## YouTube

- According to youtube [API Documentation](https://developers.google.com/youtube/player_parameters?playerVersion=HTML5) no way to play private videos. 
- What we can do is create videos as unlisted.

## Vimeo

- Create account with Pro Subscription or greater
- Upload video
- Select `Who can watch? -> People with the private link`
- Get Video url `Video Settings -> Distribution -> Video file links -> Select a link that you need` 
```
if let url = URL(string: "https://player.vimeo.com/external/385156881.sd.mp4?s=65fcb9c713848c7aba707a97df1fe15d87acf298&profile_id=164") {
    let asset = AVAsset(url: url)
    let playerItem = AVPlayerItem(asset: asset)
    let player = AVPlayer(playerItem: playerItem)
    player.allowsExternalPlayback = true
            
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
    playerLayer.videoGravity = .resizeAspectFill
    self.playerView.layer.addSublayer(playerLayer)

    player.play()
}
```
