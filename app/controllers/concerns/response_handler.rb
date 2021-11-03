# frozen_string_literal: true

# handle responses
module ResponseHandler
  extend ActiveSupport::Concern

  def render_success(resource: nil, message: '', status: 200)
    render json: {
      resource: resource,
      message: message
    }, status: status
  end

  def render_failure(errors: nil, message: '', status: 422)
    render json: {
      errors: errors,
      message: message
    }, status: status
  end
end
