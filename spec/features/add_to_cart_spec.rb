require 'rails_helper'

RSpec.feature "Add to cart", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They see all products" do
    # ACT
    visit products_path
    save_screenshot 'product_page.png'

    click_link('Details', match: :first)

    # DEBUG / VERIFY
    save_screenshot 'product_details.png'

    expect(page).to have_css 'article.product-detail'

  end
end
