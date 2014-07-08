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
				flash[:warning] = "Already linked that account!"
			else
				@auth.user = current_user
				@auth.save()
				redirect_back_or current_user
				flash[:success] = "Successfully linked that account!"
			end
		else
			if @auth.user.present?
				sign_in @auth.user
				redirect_back_or current_user
				flash[:success] = "Signed in!"
			else
				Authorization.create_new_user_from_hash(auth, current_user)
				sign_in current_user
				redirect_back_or current_user
				flash[:success] = 'Signed up' with #{@auth.provider}'
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
