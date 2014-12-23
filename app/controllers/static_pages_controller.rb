class StaticPagesController < ApplicationController
  def home
  	# Get 'request' and 'response' objects from Authentication system
  	@request = request
  	@response = response
    
    # Raise a NoMethodError if user not in Users database
    # ? Differentiate between 'development' and 'production' for how this is done
    if @request.headers["HTTP_REMOTE_USER"].blank?
      # Artificially set session
      begin
        session[:authen] = 'pgmdmjm'
        @user = User.where('authen = ?', session[:authen]).first
        session[:facility] = @user.facility
        session[:email] = @user.email
        session[:firstname] = @user.firstname
        session[:lastname] = @user.lastname
        session[:firstinitial] = @user.firstinitial
        session[:middleinitial] = @user.middleinitial
        session[:name] = ''+@user.firstinitial+' '+@user.middleinitial+' '+@user.lastname+''
        session[:role] = @user.role

        @for_select = ForSelect.where('value = ?', session[:facility]).first
        session[:facilityname] = @for_select.text
      rescue NoMethodError
        render file: "#{Rails.root}/public/user_error", layout: false
      end
      
    else
      begin
        session[:authen] = @request.headers["HTTP_REMOTE_USER"]
        @user = User.where('authen = ?', session[:authen]).first
        # session[:facility] = @request.headers["HTTP_OMHFACILITYNUM"]
        # session[:email] = @request.headers["HTTP_CTEMAIL"]
        # session[:firstname] = @request.headers["HTTP_CTFN"]
        # session[:lastname] = @request.headers["HTTP_CTLN"]
        # session[:firstinitial] = @request.headers["HTTP_CTFN"]
        # session[:middleinitial] = @request.headers["HTTP_INITIALS"]
        session[:facility] = @user.facility
        session[:email] = @user.email
        session[:firstname] = @user.firstname
        session[:lastname] = @user.lastname
        session[:firstinitial] = @user.firstinitial
        session[:middleinitial] = @user.middleinitial
        session[:name] = ''+@user.firstinitial+' '+@user.middleinitial+' '+@user.lastname+''
        session[:role] = @user.role

        @for_select = ForSelect.where('value = ?', session[:facility]).first
        session[:facilityname] = @for_select.text
      rescue NoMethodError
        render file: "#{Rails.root}/public/user_error", layout: false
      end
    end 

  # Display browser_error message if browser not chrome
  # unless @request.headers["HTTP_USER_AGENT"].downcase.include? "chrome"
  #   render :file => "#{Rails.root}/public/browser_error", :layout => false
  # end    
  
  # Raise exception if browser not chrome
  begin
    raise RuntimeError unless @request.headers["HTTP_USER_AGENT"].downcase.include? "chrome"
    rescue RuntimeError
      render file: "#{Rails.root}/public/browser_error", layout: false
  end
    

    
  end
end
