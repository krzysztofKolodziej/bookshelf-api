# frozen_string_literal: true

# Tell FactoryBot where to find factory files.
# We store them alongside the domain components they belong to.
#
# Structure:
#   spec/components/books/factories/book_factory.rb
#   spec/components/users/factories/user_factory.rb
FactoryBot.definition_file_paths += [
  Rails.root.join("spec/components")
]
