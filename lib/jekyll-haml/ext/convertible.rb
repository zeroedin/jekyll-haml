# Re-open Layout class to convert our HAML Layout content.
# This solution redeclares the Layout class in a way that
# don't risks Jekyll API updates anymore.

module Jekyll
  class << Layout
    # alias old_initialize initialize
    # def initialize(*args)
    #   old_initialize(*args)
    #   self.content = self.transform
    # end
    def initialize(site, base, name)
      @site = site
      @base = base
      @name = name

      if site.theme && site.theme.layouts_path.eql?(base)
        @base_dir = site.theme.root
        @path = site.in_theme_dir(base, name)
      else
        @base_dir = site.source
        @path = site.in_source_dir(base, name)
      end

      self.data = {}

      self.process(name)
      self.read_yaml(base, name)
      self.content = self.transform
    end
  end
end
