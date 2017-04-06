class Tab
  attr_accessor :tab, :project
  def self.avaiables
      [:about,
      :choosing_a_task_to_start_with,
      :find_a_mentor,
      :search_before_ask,
      :synchronous_chat,
      :mailing_lists,
      :setup_your_workspace,
      :deal_with_the_code,
      :submit_your_changes]
  end

  def initialize(tab, project: )
    if Tab.avaiables.include?(tab)
      self.tab = tab
      self.project = project if project
    end
  end

  private


end
