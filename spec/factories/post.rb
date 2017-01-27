FactoryGirl.define do
  factory :post do
    caption 'kitten pic'
    image Rack::Test::UploadedFile.new(Rails.root +
                                   'spec/files/images/kitten.png', 'image/png')
    user_id 1
  end
end
