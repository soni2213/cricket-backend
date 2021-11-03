# frozen_string_literal: true

module Api
  class UsersController < Api::BaseController
    before_action :find_user, only: %w[show]

    def show
      render_success(resource: @user, message: 'successful')
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
