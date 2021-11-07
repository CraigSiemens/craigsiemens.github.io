import Foundation
import Publish
import Plot

extension Theme where Site == CraigSiemensWebsite {
    static var custom: Self {
        Theme(
            htmlFactory: CraigSiemensHTMLFactory(),
            resourcePaths: [
                "Resources/Theme/styles.css",
                "Resources/Theme/swift.css",
            ]
        )
    }
    
    private struct CraigSiemensHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Index, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .content(
                        .h1("Latest content"),
                        .itemList(
                            for: context.allItems(
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
            
        }
        
        func makeSectionHTML(for section: Section<CraigSiemensWebsite>, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .content(
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
            
        }
        
        func makeItemHTML(for item: Item<CraigSiemensWebsite>, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: item, on: context.site),
                .body(
                    .class("item-page"),
                    .header(for: context, selectedSection: item.sectionID),
                    .content(
                        .article(
                            .div(
                                .class("content"),
                                .contentBody(item.body)
                            ),
                            .span("Tagged with: "),
                            .tagList(for: item, on: context.site)
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
        
        func makePageHTML(for page: Page, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .content(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
            
        }
        
        // The page that shows all the existing tags
        func makeTagListHTML(for page: TagListPage, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .content(
                        .h1("Browse all tags"),
                        .ul(
                            .class("all-tags"),
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    ),
                    .footer(for: context.site)
                )
            )
            
        }
        
        // The page that shows posts for a specific page
        func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<CraigSiemensWebsite>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .content(
                        .h1(
                            "Tagged with ",
                            .span(.class("tag"), .text(page.tag.string))
                        ),
                        .a(
                            .class("browse-all"),
                            .text("Browse all tags"),
                            .href(context.site.tagListPath)
                        ),
                        .itemList(
                            for: context.items(
                                taggedWith: page.tag,
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
            
        }
    }
}

public extension Node where Context == HTML.DocumentContext {
    static func head<T: Website>(
        for location: Location,
        on site: T
    ) -> Node {
        .head(
            for: location,
            on: site,
            stylesheetPaths: ["/styles.css", "/swift.css"]
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    /// The header show at the top of every page.
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases
        
        return .header(
            .wrapper(
                .a(
                    .class("site-name"),
                    .href("/"),
                    .text(context.site.name)
                ),
                .span(
                    .class("site-description"),
                    .text(context.site.description)
                ),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(
                                .class(section == selectedSection ? "selected" : ""),
                                .a(
                                    .href(context.sections[section].path),
                                    .text(context.sections[section].title)
                                )
                            )
                        })
                    )
                )
            )
        )
    }
    
    static func content(_ nodes: Node...) -> Node {
        .main(.wrapper(.group(nodes)))
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .wrapper(
                .p(
                    .text("Generated using "),
                    .a(
                        .text("Publish"),
                        .href("https://github.com/johnsundell/publish")
                    )
                ),
                .p(
                    .a(
                        .text("RSS feed"),
                        .href("/feed.rss")
                    )
                )
            )
        )
    }
}
