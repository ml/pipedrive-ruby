module Pipedrive
  class File < Base
    def download
      res = get(build_request_path(:download))
      res.ok? ? res : bad_response(res, {})
    end
  end
end
