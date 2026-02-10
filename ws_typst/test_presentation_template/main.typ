// Import diatypst template from templates folder
#import "../../templates/diatypst/lib.typ": *

#show: slides.with(
  title: "My Presentation",
  subtitle: "Using Typst Templates",
  date: "February 2026",
  authors: ("Your Name"),
  ratio: 16/9,
  layout: "medium",
  toc: true,
  footer: true,
  title-color: blue.darken(50%),
)

= Introduction

== Welcome

This is a simple presentation created using the *diatypst* template from the templates folder.

Features:
- Easy to use
- Professional styling
- Minimal setup required

== Getting Started

To create your own presentation:

1. Create a new project folder in `ws_typst/`
2. Reference the template from `../../templates/`
3. Add your content
4. Compile with `./scripts/compile.sh your_project`

= Content Examples

== Lists and Text

Bullet points:
- First point
- Second point
  - Nested point
  - Another nested point

Numbered list:
1. Step one
2. Step two
3. Step three

== Code Example

Here's a simple code block:

```python
def hello_world():
    print("Hello from Typst!")
    return True
```

= Conclusion

== Summary

- Templates folder contains reusable Typst templates
- Easy to reference from your projects
- Compile with Docker container

*Thank you!*
