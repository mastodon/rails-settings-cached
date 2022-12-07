require 'digest/md5'

module RailsSettings
  class Default < ::Hash
    class MissingKey < StandardError; end

    if Psych::VERSION.split('.').first >= '4'
      YAML_load_opts = { aliases: true }
    else
      YAML_load_opts = {}
    end

    class << self

      def enabled?
        source_path && File.exist?(source_path)
      end

      def source(value = nil)
        @source ||= value
      end

      def source_path
        @source || Rails.root.join('config/app.yml')
      end

      def [](key)
        # foo.bar.dar Nested fetch value
        return instance[key] if instance.key?(key)
        keys = key.to_s.split('.')
        val = instance
        keys.each do |k|
          val = val.fetch(k.to_s, nil)
          break if val.nil?
        end
        val
      end

      def instance
        return @instance if defined? @instance
        @instance = new
        @instance
      end
    end

    def initialize
      content = open(self.class.source_path).read
      hash = content.empty? ? {} : YAML.load(ERB.new(content).result, **YAML_load_opts).to_hash
      hash = hash[Rails.env] || {}
      replace hash
    end
  end
end
