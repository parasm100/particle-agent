require_relative "spec_helper"
require "particle_agent/settings"
require "tempfile"

describe ParticleAgent::Settings do
  describe "when the settings file is missing" do
    it "loads blank settings" do
      settings_file = Tempfile.new("settings")
      settings_file.close

      settings = ParticleAgent::Settings.new(settings_file.path)

      settings.load

      assert_equal({}, settings.values)
    end

    it "creates the file on save" do
      settings_file = Tempfile.new("settings")
      settings_file.close

      settings = ParticleAgent::Settings.new(settings_file.path)
      settings.values["test"] = "value"
      settings.save

      expected = %({\n  "test": "value"\n})
      actual = IO.read(settings_file.path)
      assert_equal expected, actual
    end
  end

  describe "when settings are present" do
    it "loads the settings" do
      settings_file = Tempfile.new("settings")
      settings_file.write %({"test":"value"})
      settings_file.close

      settings = ParticleAgent::Settings.new(settings_file.path)

      settings.load

      expected = { "test" => "value" }
      assert_equal expected, settings.values
    end

    it "overwrites the file on save" do
      settings_file = Tempfile.new("settings")
      settings_file.write %({"test":"old"})
      settings_file.close

      settings = ParticleAgent::Settings.new(settings_file.path)
      settings.values["test"] = "value"
      settings.save

      expected = %({\n  "test": "value"\n})
      actual = IO.read(settings_file.path)
      assert_equal expected, actual
    end
  end
end
