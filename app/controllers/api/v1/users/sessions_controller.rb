class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create

    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    token = request.env['warden-jwt_auth.token']

    render json: { user: resource, token: token }
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

    render json: { message: 'Signed out successfully.', signout: signed_out }
  end
end
