module ExercismWeb
  module Presenters
    class Inbox
      attr_reader :user
      def initialize(user)
        @user = user
      end

      def count
        notifications.count + team_membership_invites.count
      end

      def has_notifications?
        notifications.count > 0
      end

      def has_team_membership_invites?
        team_membership_invites.count > 0
      end

      def has_membership_requests_to_review?
        user.managed_teams.exists? && membership_requests_to_review.size > 0
      end

      def notifications
        user.notifications.includes(:iteration, :actor).unread.recent.reject { |note| note.iteration.nil? || note.iteration.user.nil? }
      end

      def team_membership_invites
        user.team_membership_invites
      end

      def membership_requests_to_review
        user.managed_teams.map(&:membership_requests).flatten
      end
    end
  end
end
