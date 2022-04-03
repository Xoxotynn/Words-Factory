import AVFoundation

class AudioService {
    
    // MARK: - Properties
    private var audioPlayer: AVPlayer?
    
    // MARK: - Public Methods
    func playSound(audio: String) {
        guard let audioUrl = URL(string: audio) else { return }
        let playerItem = AVPlayerItem(url: audioUrl)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
}
