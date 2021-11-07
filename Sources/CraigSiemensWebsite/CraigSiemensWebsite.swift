import Foundation
import Publish
import Plot

struct CraigSiemensWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        
    }
    
    var url = URL(string: "https://craigsiemens.com")!
    var name = "Craig Siemens"
    var description = "Making errors in new and clever ways."
    var language: Language = .english
    var imagePath: Path?
}
