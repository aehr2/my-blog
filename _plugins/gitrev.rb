module Jekyll
  class GitRev < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path
    end

    def render(context)
      # Pipe parameter through Liquid to make additional replacements possible
      url = Liquid::Template.parse(@path).render context

      # Adds the site source, so that it also works with a custom one
      site_source = context.registers[:site].config['source']
      file_path = site_source + '/' + url
      last_rev = %x{git log -n 1 --pretty=format:%H -- #{file_path.strip!}}

      %Q{Last changed: <a href="https://github.com/peri4n/blog/commits/master/#{last_rev}">#{last_rev}</a>}
    end
  end
end

Liquid::Template.register_tag('git_rev', Jekyll::GitRev)
