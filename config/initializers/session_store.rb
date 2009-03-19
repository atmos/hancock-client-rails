# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hancock-client-rails_session',
  :secret      => '1d02aefc4ae6cabbaf937adaf42cc908975ddced6c0b01073850ceab7db18f759f34367e7804cd0b12307941faf263c10ca8e23c051af396e6741f854448de69'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
