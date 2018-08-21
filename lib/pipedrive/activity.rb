require 'date'

module Pipedrive
  class Activity < Base
    # Gets the date of the activity
    #
    # @return [DateTime]
    def date
      DateTime.parse(due_date + ' ' + due_time)
    end

    # Gets the organization associated to the activity
    #
    # @params [Boolean] force_reload
    # @return [Organization]
    def organization(force_reload = false)
      # Get Organization if id is set and if not already set
      if !org_id.nil? && (self[:organization].nil? || force_reload)
        self[:organization] = Organization.find(org_id)
      end

      self[:organization]
    end
  end
end
