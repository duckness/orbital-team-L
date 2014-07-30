class SessionsController < ApplicationController
	def new
	end

	def create_with_identity
		auth = request.env["omniauth.auth"]
	    @auth = Authorization.find_from_hash(auth)
	    if @auth.nil?
		    # Create a new auth or add an auth 
			@auth = Authorization.create_from_hash(auth)
     	end
     	if signed_in?
     		if @auth.user == current_user
     			redirect_back_or current_user
				flash[:warning] = "Already linked with #{@auth.provider.split('_').join(' ').capitalize}!"
			else
				@auth.user = current_user
				@auth.save()
				redirect_back_or current_user
				flash[:success] = "Successfully linked with #{@auth.provider.split('_').join(' ').capitalize}!"
			end
		else
			if @auth.user.present?
				sign_in @auth.user
				redirect_back_or current_user
				flash[:success] = "Signed in!"
			else
				if (current_user = User.find_by(email: auth['info']['email']))
					@auth.user = current_user
					@auth.save()
					sign_in current_user
					redirect_back_or current_user
					flash[:success] = "Signed in and linked with #{@auth.provider.split('_').join(' ').capitalize}"
				else
					current_user = Authorization.create_new_user_from_hash(auth, current_user)
					@auth.user = current_user
					@auth.save()
					sign_in current_user
					redirect_back_or current_user
					flash[:success] = %Q[Signed up your new account with #{@auth.provider.split('_').join(' ').capitalize}. <br> You may want to change your password <a href="/user/#{current_user.id}/edit">here</a>].html_safe
				end
			end
		end
  	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
  		if user && user.authenticate(params[:session][:password])
		    sign_in user
		    redirect_back_or user
		else
		   	flash.now[:danger] = 'Invalid email/password combination'
     		render 'new'
		end
	end

	def destroy
		sign_out
   		redirect_to root_url
	end

end
