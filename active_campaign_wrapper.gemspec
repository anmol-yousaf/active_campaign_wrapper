require_relative 'lib/active_campaign_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "active_campaign_wrapper"
  spec.version       = ActiveCampaignWrapper::VERSION
  spec.authors       = ["Anmol Yousaf"]
  spec.email         = ["anmolyousaf94@gmail.com"]

  spec.summary       = %q{REST API for ActiveCampaign}
  spec.description   = %q{ActiveCampaign REST API}
  spec.homepage      = "https://github.com/anmol-yousaf/active_campaign_wrapper"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/anmol-yousaf/active_campaign_wrapper"
  spec.metadata["changelog_uri"] = "https://github.com/anmol-yousaf/active_campaign_wrapper"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '~> 4.2.6'
  spec.add_dependency 'httparty', '~> 0.18.1'
end
