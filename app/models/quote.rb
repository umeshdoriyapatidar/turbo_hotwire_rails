class Quote < ApplicationRecord
  validates :name, presence: true
  scope :ordered, -> { order(id: :desc) }
  # after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
  # after_update_commit -> { broadcast_replace_to "quotes" }
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }
  # Above three call back are equivalent to the following sinle line of lambda
  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
