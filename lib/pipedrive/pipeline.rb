module Pipedrive
  class Pipeline < Base
    def stages
      Stage.all(query: { pipeline_id: self.id })
    end

    def statistics(id, start_date, end_date)
      options = { :query => { :start_date => start_date, :end_date => end_date }}
      res     = get("#{resource_path}/#{id}/movement_statistics", options)

      res.ok? ? new(res) : bad_response(res,{ :id => id, :start_date => start_date, :end_date => end_date })
    end

    def deals(id, stage_id)
      Pipedrive::Deal.all(request_path: "#{resource_path}/#{id}/deals", query: { :stage_id => stage_id })
    end
  end
end
