# frozen_string_literal: true

module StateHelper
  # A helper to retieve a list of US states. Data is kept in the i18n file `en.yml`
  def us_states
    t 'us_states'
  end
end
