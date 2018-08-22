module Pipedrive
  class Person < Base
    class << self
      def find_or_create_by_name(name, opts = {})
        find_by_name(name, :org_id => opts[:org_id]).first || create(opts.merge(:name => name))
      end
    end

    def deals
      Deal.all(request_path: "#{resource_path}/#{id}/deals")
    end

    def flow(options = {})
      res = get("#{resource_path}/#{id}/flow", options)
      res.ok? ? res['data'] : bad_response(res, options)
    end

    def merge(options = {})
      res = put "#{resource_path}/#{id}/merge", :body => options
      res.success? ? res['data'] : bad_response(res, options)
    end

    def products(options = {})
      Product.all(options.merge(request_path: "#{resource_path}/#{id}/products"))
    end
  end
end
