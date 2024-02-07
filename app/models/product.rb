class Product < ApplicationRecord
    has_one_attached :image
    has_many :orderables
    has_many :carts, through: :orderables

    validates :name, :description, :category, :image, :presence => true
    validates_numericality_of :price, :only_integer => true, :greater_than => 0

    def image_as_thumbnail
        return unless image.content_type.in? (%w[image/jpeg image/png image/jpg])
        image.variant(resize_to_limit: [200, 200]).processed
    end

    def cover_image
        image.variant(resize_to_limit: [550, 550]).processed
    end

    def feature_image
        image.variant(resize_to_limit: [100, 100]).processed
    end

end
