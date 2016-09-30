class Member
  class IndexQuery
    include ActiveModel::Model

    attr_accessor :trial, :active, :sporadic, :on_break, :other, :patches,
      :bus_drivers, :section_leads

    def members
      query = Member.where(nil)
      query = query.where(status: status_map) if status_map.any?
      query = query.where(has_patch: true) if self.patches == "1"
      query = query.where(has_bus_insurance: true) if self.bus_drivers == "1"
      query = query.where(section_lead: true) if self.section_leads == "1"

      query
    end

    private

    def status_map
      @status_map = []

      @status_map << trial_status if self.trial == "1"
      @status_map << active_status if self.active == "1"
      @status_map << sporadic_status if self.sporadic == "1"
      @status_map << on_break_status if self.on_break == "1"
      @status_map << other_status if self.other == "1"

      @status_map.flatten
    end

    def trial_status
      Member.statuses[:trial]
    end

    def active_status
      Member.statuses[:active]
    end

    def sporadic_status
      Member.statuses[:sporadic]
    end

    def on_break_status
      Member.statuses[:on_break]
    end

    def other_status
      Member.statuses.values - [trial_status, active_status, sporadic_status,
        on_break_status]
    end
  end
end
