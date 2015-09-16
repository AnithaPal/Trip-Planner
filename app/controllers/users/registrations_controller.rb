class Users::RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})

    if params[:invite_token]
      @invite = Invite.find_by(token: params[:invite_token])
      resource.email = @invite.email
      @trip_id = @invite.trip_id
    end

    respond_with self.resource
  end

  def create

    @invite = Invite.find_by(token: params[:invite_token]) if params[:invite_token]

    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?

      @invite.accepted(resource) if @invite

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        if @invite
          respond_with resource, location: trip_path(@invite.trip)
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
