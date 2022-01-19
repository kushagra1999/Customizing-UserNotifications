/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Contains ImageContentExtension's NotificationViewController.
*/

import UIKit
import UserNotifications
import UserNotificationsUI
import AVKit
import AVFoundation
/// - Tag: NotificationViewController
class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var likeLabel: UILabel!
    var videoPlayer: AVPlayer?
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else { return }

        // Get the attachment and set the image view.
        if attachment.url.startAccessingSecurityScopedResource(){
            videoPlayer = AVPlayer(url: attachment.url)
            

            attachment.url.stopAccessingSecurityScopedResource()
        }
        

    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        // Handle various actions.
        if response.actionIdentifier == "likeAction" {
            likeLabel.isHidden = false
        } else if response.actionIdentifier == "reactAction" {
            becomeFirstResponder()
        }

        // Dont dismiss extension to allow further interaction.
        completion(.doNotDismiss)
    }



}

