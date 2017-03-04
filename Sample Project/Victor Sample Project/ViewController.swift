//
//  ViewController.swift
//  Victor Sample Project
//
//  Created by Seán Labastille on 04.03.17.
//
//

import UIKit
import Victor
import QuickLook

class ViewController: UIViewController {

    @IBOutlet weak var canvasImageView: UIImageView!
    private let parser = Parser(file: "\(Bundle.main.url(forResource: "rect02", withExtension: "svg")!)")

    fileprivate var pdfURL: URL? {
        get {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                return URL(fileURLWithPath: "renderedSVG.pdf", relativeTo: documentDirectory)
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let svg = parser.parse(), let pdfURL = pdfURL {
            let pdfData = Renderer().render(svg)
            try! pdfData.write(to: pdfURL)
            let quickLook = QLPreviewController()
            quickLook.dataSource = self
            present(quickLook, animated: true, completion: nil)
        }
    }
    }

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return pdfURL as! NSURL
    }
}

