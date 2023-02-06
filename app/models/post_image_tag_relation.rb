class PostImageTagRelation < ApplicationRecord
  belongs_to :PostImage
  belongs_to :tag
end
