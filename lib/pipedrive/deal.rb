module Pipedrive
  class Deal < Base
    def add_product(options = {})
      res = post build_request_path(:products), :body => options
      res.success? ? res['data']['product_attachment_id'] : bad_response(res, options)
    end

    def products(options = {})
      Product.all(options.merge(request_path: build_request_path(:products)))
    end

    def add_participant(options = {})
      res = post build_request_path(:participants), :body => options
      res.success? ? true : bad_response(res, options)
    end

    def participants(options = {})
      Person.all(options.merge(request_path: build_request_path(:participants)))
    end

    def remove_product(product_attachment_id)
      res = delete build_request_path(:products), { :body => { :product_attachment_id => product_attachment_id } }
      res.success? ? nil : bad_response(res,product_attachment_id)
    end

    def activities(options = {})
      Activity.all(options.merge(request_path: build_request_path(:activities)))
    end

    def files(options = {})
      File.all(options.merge(request_path: build_request_path(:files)))
    end

    def flow(options = {})
      res = get(build_request_path(:flow), options)
      res.ok? ? res['data'] : bad_response(res, options)
    end

    def followers(options = {})
      res = get(build_request_path(:followers), options)
      res.ok? ? res['data'] : bad_response(res, options)
    end

    def add_note(content)
      Note.create(deal_id: id, content: content)
    end

    def notes(options = {})
      defaults = { query: { sort_by: :add_time, sort_mode: :desc }}
      options.deep_merge!(query: { deal_id: id })

      Note.all(defaults.deep_merge(options))
    end
  end
end
