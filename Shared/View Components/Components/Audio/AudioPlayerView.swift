import AVFoundation
import SwiftUI

/// A view that just has a play/pause button and a slider
/// to scrub through the audio.
struct AudioPlayerView: View {
    @State var title: String?
    @State private var titleWidth: CGFloat?

    /// The player, which wraps an AVPlayer
    @ObservedObject private var player: Player

    init(title: String? = nil, audioUrl: String) {
        self = AudioPlayerView(title: title, audioUrl: URL(string: audioUrl))
    }

    init(title: String? = nil, audioUrl: URL?) {
        self.title = title
        if let audioUrl = audioUrl {
            let playerItem = AVPlayerItem(url: audioUrl)
            player = Player(avPlayer: AVPlayer(playerItem: playerItem))
        } else {
            player = Player(avPlayer: AVPlayer())
        }
    }

    var body: some View {
        VStack(spacing: 4) {
            if let title = title {
                Text(title)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .background {
                        GeometryReader { geo in
                            executeAsync {
                                if titleWidth != geo.size.width {
                                    titleWidth = geo.size.width
                                }
                            }
                        }
                    }
            }
            /// This is a bit of a hack, but it takes a moment for the AVPlayerItem to load
            /// the duration, so we need to avoid adding the slider until the range
            /// (0...self.player.duration) is not empty.
            if self.player.itemDuration > 0 {
                VStack(spacing: 2) {
                    Slider(value: self.$player.displayTime, in: 0 ... self.player.itemDuration, onEditingChanged: {
                        scrubStarted in
                        if scrubStarted {
                            self.player.scrubState = .scrubStarted
                        } else {
                            self.player.scrubState = .scrubEnded(self.player.displayTime)
                        }
                    })
                    .accentColor(.red)
                    HStack {
                        Text(self.durationFormatter.string(from: self.player.displayTime) ?? "")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                        Spacer()
                        Button(action: {
                            switch self.player.timeControlStatus {
                            case .paused:
                                self.player.play()
                            case .waitingToPlayAtSpecifiedRate:
                                self.player.pause()
                            case .playing:
                                self.player.pause()
                            @unknown default:
                                fatalError()
                            }
                        }) {
                            Image(systemName: self.player.timeControlStatus == .paused ? "play.circle" : "pause.circle")
                                .font(.system(size: 30))
                                .foregroundColor(.primary.opacity(0.7))
                        }
                        Spacer()
                        Text(self.durationFormatter.string(from: self.player.itemDuration) ?? "")
                            .font(.system(size: 14, weight: .medium, design: .monospaced))
                    }
                }
                .frame(width: (titleWidth ?? 0) + 32)
            } else {
                Text("Slider will appear here when the player is ready")
                    .font(.footnote)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
                .border(Color.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .primary.opacity(0.1), radius: 10)
        .padding()
    }

    /// Return a formatter for durations.
    var durationFormatter: DateComponentsFormatter {
        let durationFormatter = DateComponentsFormatter()
        durationFormatter.allowedUnits = [.minute, .second]
        durationFormatter.unitsStyle = .positional
        durationFormatter.zeroFormattingBehavior = .pad

        return durationFormatter
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(title: "Introduction audio(English)", audioUrl: "https://dea3n992em6cn.cloudfront.net/museumcollection/000932-en-20210324-v1.mp3")
            .padding()
    }
}
