$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require "particle_agent/version"

Gem::Specification.new do |s|
  s.name = "particle-agent"
  s.version = ParticleAgent::VERSION.dup
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = %w(README.md LICENSE)
  s.summary = "This program supervises the Particle firmware executable running on Raspberry Pi"
  s.description = s.summary
  s.license = "Apache-2.0"
  s.author = "Julien Vanier"
  s.email = "julien@particle.io"
  s.homepage = "http://www.particle.io"

  s.required_ruby_version = ">= 2.0.0"

  s.add_dependency "particlerb", "~> 1.3"

  # CLI
  s.add_dependency "thor", "~> 0.19"

  # Spinner
  s.add_dependency "whirly", "~> 0.2"

  # Prompt
  s.add_dependency "highline", "~> 1.6"

  # Testing
  s.add_development_dependency "minitest", "~> 5.9"

  s.bindir       = "bin"
  s.executables  = %w(particle-agent particle-agent-service)

  s.require_paths = %w(lib)
  s.files = %w(Gemfile Rakefile LICENSE README.md) + Dir.glob("*.gemspec")
  s.files += Dir.glob(
    "{debian,lib,share,spec}/**/*",
    File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
end
