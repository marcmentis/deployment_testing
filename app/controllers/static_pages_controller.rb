class StaticPagesController < ApplicationController
  def home
  	# Get 'request' and 'response' objects from Authentication system
  	@request = request
  	@response = response
    
    if @request.headers["HTTP_REMOTE_USER"].blank?
      # Artificially set session
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
      session[:facname] = @for_select.text
      
    else
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
    end 	
  end
end
