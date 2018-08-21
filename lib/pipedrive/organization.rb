module Pipedrive
  class Organization < Base
    class << self
      def find_or_create_by_name(name, opts={})
        find_by_name(name).first || create(opts.merge(:name => name))
      end
    end

    def persons
      Person.all(resource_path: "#{resource_path}/#{id}/persons")
    end

    def deals
      Deal.all(resource_path: "#{resource_path}/#{id}/deals")
    end
  end
end
