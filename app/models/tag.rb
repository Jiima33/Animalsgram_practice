class Tag < ApplicationRecord
  has_many :PostImage_tag_relations, dependent: :destroy
  has_many :PostImages, through: :PostImage_tag_relations, dependent: :destroy
end
