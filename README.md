# XcodeFileListTemplateSync

<img src="https://i.imgur.com/Ayzdvmx.png"></img>

Xcode supports adding custom file templates in **File -> New**, but doing this requires adding such templates to a folder inside your computer's Library folder. That's not very team oriented!

`XcodeFileListTemplateSync` is a CLI tool that allows you to create file templates that can be used from anywhere, and thus can be versioned and shared with your team.
It works by simply copying a `XcodeFileListTemplate` folder into the correct path, but this allows you to commit your shared file templates in your repo. This way, you can make changes to them and have them propagate to your team members when such commits are pulled.

# Installation

- Download a binary from <a href="https://github.com/rockbruno/XcodeFileListTemplateSync/releases">GitHub's release page.</a>
- Place it somewhere inside your repo
- Inside your repo, create a folder to contain your templates. This should behave just like Xcode's folder, so there should be a second folder inside of it that represents the section that is being added. Here's the example that generated the picture from this repo: `
myRepo/XcodeFileTemplates/SwiftRocks/{the templates}`

# Usage

- Run the following command: `XcodeFileListTemplateSync {path_to_folder_containing_template_sections}`
- Example: `XcodeFileListTemplateSync ./XcodeFileTemplates`

# Recommended Usage

- To make sure everyone on the team always has their templates updated, I recommended automating the usage of this tool. You could put it as a post-run script of your builds, a step of your xcodeproj generation process (if you do that), or as a `git pull` hook (the most efficient alternative).

# Creating Templates

- <a href="https://thoughtbot.com/blog/creating-custom-xcode-templates">Follow this tutorial</a>
