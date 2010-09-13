class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_language
  before_filter :require_user
  helper_method :current_user_session, :current_user

  protected

  def current_patient=(patient)
    @patient = patient
    session[:patient_id] = patient.nil? ? nil : patient.id
    logger.info("#{patient} set as current")
  end
  
  def current_patient
    @patient = find_object_referenced_by(:patient_id, Patient)
  end

  def current_invoice=(invoice)
    @invoice = invoice
    session[:invoice_id] = invoice.nil? ? nil : invoice.id
  end
  def current_invoice
    @invoice = find_object_referenced_by(:invoice_id, Invoice)
  end
  
  def find_object_referenced_by(sym, model)
    id = [params[sym], session[sym]].compact.first
    if id
      begin
        obj = model.find(id)
        session[sym] = id
      rescue
        session[sym] = nil
      end
    end
    obj
  end

  private
  
  def set_user_language
    I18n.locale = params[:locale] if params[:locale]
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
    
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
    
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
    
  def store_location
    session[:return_to] = request.request_uri
  end
    
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
