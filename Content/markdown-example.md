---
date: 2021-02-25 13:17
title: Markdown Examples
description: About Craig Siemens
---

# h1 Heading 8-)
## h2 Heading
### h3 Heading
#### h4 Heading
##### h5 Heading
###### h6 Heading


## Horizontal Rules

---

## Emphasis

**This is bold text**

__This is bold text__

*This is italic text*

_This is italic text_

~~Strikethrough~~


## Blockquotes

a follwoing line

> Blockquotes
> multiple lines

a follwoing line 

## Lists

Unordered

- Create a list by starting a line with `+`, `-`, or `*`
- Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    - Ac tristique libero volutpat at
    - Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
- Very easy!

Ordered

1. Lorem ipsum dolor sit amet
  - asdf
  - asdf
    - asdf

1. Consectetur adipiscing elit
1. Integer molestie lorem at massa

## Code

Inline `code` asdf asdf asdf asdf asdf asdf asdf asdf  `some really long inline thing that might have something bad happen` asdf asdf asdf asdf asdf asdf asdf asdf

Block code "fences"

```swift
Sample text here...
```

Syntax highlighting

```swift
import Foundation

// Foo
struct Foo {
    var value: Int
    
    init() {
        self.value = Int.random(in: 0...10)
    }
    
    func sayHello() {
        print("Hello, \(value)")
    }
}
```

## Tables

| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |

Right aligned columns

| Option | Description |
| ------:| -----------:|
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |


## Links

[link text](http://dev.nodeca.com)

## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg)
