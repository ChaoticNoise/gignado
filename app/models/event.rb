class Event < ActiveRecord::Base
  serialize :data, HashSerializer
end
