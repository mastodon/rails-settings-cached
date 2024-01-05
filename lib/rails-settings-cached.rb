require_relative 'rails-settings/default'
require_relative 'rails-settings/extend'
require_relative 'rails-settings/version'

module RailsSettings
  autoload :Base, 'rails-settings/base'
  autoload :CachedSettings, 'rails-settings/cached_settings'
  autoload :Settings, 'rails-settings/settings'
  autoload :ScopedSettings, 'rails-settings/scoped_settings'
end
