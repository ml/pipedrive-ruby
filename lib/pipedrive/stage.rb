module Pipedrive
  class Stage < Base
    def deals
      Deal.all(request_path: "#{resource_path}/#{id}/deals", query: { everyone: 1 })
    end
  end
end
