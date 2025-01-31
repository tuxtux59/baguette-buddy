class Receipe < ApplicationRecord
  before_validation :generate_slug
  belongs_to :user
  has_many :ingredients

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :description, presence: true
  validates :portions_number, numericality: {greater_than_or_equal_to: 1}

  def base64_content
    Base64.encode64(self.illustration.to_s)
  end

  def image_type
    image_content_type(self.base64_content)
  end

  def base64_data
    data = "data:#{self.image_type};base64, #{self.base64_content}"
    return data
  end

  private

  def generate_slug
    self.slug = self.title.parameterize.underscore if self.title
  end

  IMAGE_SIGNATURES = {
    R0lGODdh: 'image/gif',
    R0lGODlh: 'image/gif',
    iVBORw0KGgo: 'image/png',
    '/9j/': 'image/jpg',
    Qk02U: 'image/bmp',
    '/9sIA+gD': 'image/jpeg',
    '/0x90h+': 'image/tiff',
    RAwwAHQAu: 'image/webp',
    UklGR: 'image/webp',
  }

  def image_content_type(content)
    return IMAGE_SIGNATURES.find do |signature, content_type|
      return content_type if content.start_with?(signature.to_s)
    end
  end
end
