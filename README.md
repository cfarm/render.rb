render.rb
=========

Render an include file from anywhere in your Jekyll project


## How to use this plugin

1. Add the [_render.rb](https://github.com/cfarm/render.rb) file to your _includes directory.
2. Use the render tag to include a file from anywhere else in your project. Filepaths are relative to the present working directory.

## Examples

## Example 1
`{% render about/_bio.markdown %}`

This will import source/about/_bio.markdown and render it inline. Use an underscore at the beginning of the filename to prevent Jekyll from generating an about/bio.html (Jekyll doesn't convert files beginning with underscores).

## Example 2
`{% render templates/includes/header.html %}`

If you have a folder for your include files that you want to include in your templates and compile using Jekyll, you can include the markup from those files using this tag.