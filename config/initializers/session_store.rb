# Be sure to restart your server when you modify this file.

Jessedearing::Application.config.session_store :cookie_store, :key => '_jessedearing_session', :expires => 1.week.from_now

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Jessedearing::Application.config.session_store :active_record_store
