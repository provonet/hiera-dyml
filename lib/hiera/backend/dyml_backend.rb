class Hiera
  module Backend
    class Dyml_backend
      #based on the original Hiera Yaml backend, modified to use the deep_merge hash function to merge the hiera yaml files.

      def initialize
        require 'yaml'
        require 'deep_merge/rails_compat'
        Hiera.debug("Hiera Dyml backend starting")
      end

      def deep_merge_options
        @options ||= {}.tap do |options|
          backend_options = Hiera::Config[:dyml]
          [:knockout_prefix, :preserve_unmergeables, :sort_merged_arrays, :unpack_arrays].each do |key|
            options[key] = backend_options[key] if backend_options.include?(key)
          end
        end
      end

      def lookup(key, scope, order_override, resolution_type)
        answer = nil
        Hiera.debug("Looking up #{key} in DYML backend")
        files = []
        data = {}
        Backend.datasources(scope, order_override) do |source|
          Hiera.debug("Looking for data source #{source}")
          yamlfile = Backend.datafile(:dyml, scope, source, "yaml") || next
          files << yamlfile
        end

        files.reverse.each { |f| data.deeper_merge!(YAML.load_file(f), deep_merge_options) } unless files.empty?

        if data.include?(key)
          new_answer = Backend.parse_answer(data[key], scope)
          case resolution_type
          when :array
            raise Exception, "Hiera type mismatch: expected Array and got #{new_answer.class}" unless new_answer.kind_of? Array or new_answer.kind_of? String
            answer << new_answer
          when :hash
            raise Exception, "Hiera type mismatch: expected Hash and got #{new_answer.class}" unless new_answer.kind_of? Hash
            answer = new_answer.merge answer
          else
            answer = new_answer
          end
        end

        return answer
      end
    end
  end
end
