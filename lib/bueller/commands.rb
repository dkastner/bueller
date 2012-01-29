class Jeweler
  module Commands
    autoload :WriteGemspec, 'jeweler/commands/write_gemspec'

    module Version
      autoload :Base,      'jeweler/commands/version/base'
      autoload :BumpMajor, 'jeweler/commands/version/bump_major'
      autoload :BumpMinor, 'jeweler/commands/version/bump_minor'
      autoload :BumpPatch, 'jeweler/commands/version/bump_patch'
      autoload :Write,     'jeweler/commands/version/write'
    end
  end
end
