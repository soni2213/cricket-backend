# frozen_string_literal: true

# handle exceptions
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from StandardError, with: :all_standard_error
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    # rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  end

  def record_not_found(_exception)
    render_failure(status: 404, message: 'record not found')
  end

  def record_not_unique(_exception)
    render_failure(status: :unprocessable_entity, message: 'record not unique')
  end

  def all_standard_error(_exception)
    render_failure(status: 500, message: 'Something went wrong!')
  end

  def record_invalid(exception)
    errors = begin
      exception.record.errors.messages
    rescue StandardError
      {}
    end

    render_failure(errors: errors, status: :unprocessable_entity, message: exception.try(:message))
  end
end
