RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end


  config.main_app_name = 'Kindred Britain'

  # Disable .js form validation
  config.browser_validations = false


  config.included_models = [
    Indiv,
    Event,
    Particip,
    Occu,
    Place,
  ]

  config.model Indiv do
    label 'Individuals'
  end

  config.model Event do
    label 'Events'
  end

  config.model Particip do
    label 'Participations'
  end

  config.model Occu do
    label 'Occupations'
  end

  config.model Place do
    label 'Places'
  end


end
