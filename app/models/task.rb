class Task < ApplicationRecord
  # Relationship: each task belongs to a user
  belongs_to :user
end
