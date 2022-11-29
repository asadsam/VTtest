
import Foundation
import UIKit

//@TODO: cache downloaded images

extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, placeholder: UIImage? = nil) {
        contentMode = mode
        image = placeholder
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error on download \(error ?? URLError(.badServerResponse))")
                return
            }
            guard 200 ..< 300 ~= response.statusCode else {
                print("statusCode != 2xx; \(response.statusCode)")
                return
            }
            guard let image = UIImage(data: data) else {
                print("not valid image")
                return
            }
            DispatchQueue.main.async {
                print("download completed \(url.lastPathComponent)")
                self.image = image
            }
        }.resume()
    }
}
