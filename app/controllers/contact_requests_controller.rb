class ContactRequestsController < ApplicationController
  before_action :authorize_request, except: [:create]
  before_action :set_contact_request, only: %i[ show update destroy ]

  # GET /contact_requests
  def index
    @contact_requests = ContactRequest.all

    render json: @contact_requests
  end

  # GET /contact_requests/1
  def show
    render json: @contact_request
  end

  # POST /contact_requests
  def create
    @contact_request = ContactRequest.new(contact_request_create_params)

    if @contact_request.save
      render json: @contact_request, status: :created
    else
      @errors = @contact_request.errors.messages.map do |attribute, messages|
        messages.map { |message| "#{attribute.to_sym}: #{message}" }
      end.flatten(1)
      render_error @errors, :unprocessable_entity
      # render json: @contact_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_requests/1
  def update
    if @contact_request.update(contact_request_params)
      render json: @contact_request
    else
      render json: @contact_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contact_requests/1
  def destroy
    @contact_request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_request
      @contact_request = ContactRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_request_create_params
      params.permit(:name, :cellphone, :email)
    end
end
