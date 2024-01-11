require_relative "lib/qweixin/version"

Gem::Specification.new do |spec|
  spec.name        = "qweixin"
  spec.version     = Qweixin::VERSION
  spec.authors     = ["qichunren"]
  spec.email       = ["whyruby@gmail.com"]
  spec.homepage    = "https://github.com/qichunren"
  spec.summary     = "Qweixin is a rails engine that power weixin feature."
  spec.description = "Qweixin is a rails engine that power weixin feature."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/qichunren/sitebuilder"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/qichunren/sitebuilder"
  spec.metadata["changelog_uri"] = "https://github.com/qichunren/sitebuilder/Changelog"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.2"
end
