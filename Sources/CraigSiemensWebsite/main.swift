import Publish
import SplashPublishPlugin

try CraigSiemensWebsite()
    .publish(using: [
        .installPlugin(.splash(withClassPrefix: "")),
        .optional(.copyResources()),
        .addMarkdownFiles(),
        .sortItems(by: \.date, order: .descending),
        .generateHTML(withTheme: .custom),
        .generateRSSFeed(including: [.posts]),
        .generateSiteMap()
    ])
