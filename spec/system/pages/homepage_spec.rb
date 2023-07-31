# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home page', type: :system do
  it 'shows button to weather modal' do
    visit root_path

    expect(page).to have_selector(:link_or_button, 'VIEW MY WEATHER')
  end
end
