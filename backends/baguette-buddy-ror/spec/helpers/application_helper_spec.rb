require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
describe ApplicationHelper, type: :helper do
  describe "string concat" do
    let(:expected_width) { 800 }
    let(:expected_height) { 800 }
    
    let(:src_path) { Rails.root.join('test', 'fixtures', 'files', 'image.jpg') }

    it "concats two strings with spaces" do
      optimized_illustration = helper.optimize_illustration(src_path)
      expect(optimized_illustration).not_to be_nil

      image = MiniMagick::Image.read(optimized_illustration, "png")
      expect(image).not_to be_nil
      expect(image.width).to eq 800
      expect(image.height).to eq 567
    end
  end
end
