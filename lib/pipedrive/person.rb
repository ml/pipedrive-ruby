module Pipedrive
  class Person < Base
    class << self
      def find_or_create_by_name(name, options = {})
        find_by(name, options).first || create(options.merge(name: name))
      end
    end

    def activities(options = {})
      Activity.all(options.merge(request_path: build_request_path(:activities)))
    end

    def deals(options = {})
      Deal.all(options.merge(request_path: build_request_path(:deals)))
    end

    def files(options = {})
      File.all(options.merge(request_path: build_request_path(:files)))
    end

    def flow(options = {})
      res = get(build_request_path(:flow), options)
      res.ok? ? res['data'] : bad_response(res, options)
    end

    def merge(options = {})
      res = put build_request_path(:merge), :body => options
      res.success? ? res['data'] : bad_response(res, options)
    end

    def products(options = {})
      Product.all(options.merge(request_path: build_request_path(:products)))
    end
  end
end
