class StatusController < ApplicationController

  def check
    render :json => {
      'git_tag'         => `git describe`.chomp,
      'git_hash'        => `git log --format="%h" -1`.chomp,
      'schema_version'  => ActiveRecord::Migrator.current_version,
      'rails_env'       => Rails.env.to_s
    }
  end
end
