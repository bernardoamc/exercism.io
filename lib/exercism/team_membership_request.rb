class TeamMembershipRequest < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates :user, uniqueness: { scope: :team }
  scope :for_team, -> (team_id) { where(team_id: team_id) }
  scope :denied, -> { where(denied: true) }

  def accept!
    ActiveRecord::Base.transaction do
      TeamMembership.create!(team_id: team_id, user_id: user_id, confirmed: true)
      destroy
    end
  end

  def deny!
    self.denied = true
    save
  end
end
