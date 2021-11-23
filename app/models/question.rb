# frozen_string_literal: true

class Question < ApplicationRecord
  enum kind: { interpelare: 1, intrebare: 0 }

  belongs_to :deputy_legislature
end
