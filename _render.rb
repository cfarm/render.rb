# Liquid::Template.register_tag('render_file', Jekyll::RenderFile)
# Title: Render Partial Tag for Jekyll
# Author: Catherine Farman, based on the Render Partial Octopress Plugin by Brandon Mathis https://github.com/imathis/octopress/blob/master/plugins/render_partial.rb
# Description: Import files on your filesystem into any blog post and render them inline.
# Note: Paths are relative to the present working directory.
#
# Syntax {% render path/to/file %}
#
# Example 1:
# {% render about/_bio.markdown %}
#
# This will import source/about/_bio.markdown and render it inline.
# In this example I used an underscore at the beginning of the filename to prevent Jekyll
# from generating an about/bio.html (Jekyll doesn't convert files beginning with underscores)
#
# Example 2:
# {% render templates/includes/header.html %}
# Some projects may have a separate templates folder to create template code. 
# You can include markup from those files using this tag.
#
#

require 'pathname'

module Jekyll

  class RenderPartialTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @file = nil
      @raw = false
      if markup =~ /^(\S+)\s?(\w+)?/
        @file = $1.strip
        @raw = $2 == 'raw'
      end
      super
    end

    def render(context)
      file_dir = Dir.pwd
      file_path = Pathname.new(file_dir).expand_path
      file = file_path + @file

      unless file.file?
        return "File #{file} could not be found"
      end

      Dir.chdir(file_path) do
        contents = file.read
        if contents =~ /\A-{3}.+[^\A]-{3}\n(.+)/m
          contents = $1.lstrip
        end
        if @raw
          contents
        else
          partial = Liquid::Template.parse(contents)
          context.stack do
            partial.render(context)
          end
        end
      end
    end
  end
end

Liquid::Template.register_tag('render', Jekyll::RenderPartialTag)