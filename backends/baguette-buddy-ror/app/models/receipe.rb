class Receipe < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :portions_number, numericality: {greater_than_or_equal_to: 1}

  def base64_content
    Base64.encode64(self.illustration.to_s)
  end

  def image_type
    return image_content_type(self.base64_content)
  end

  private

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
