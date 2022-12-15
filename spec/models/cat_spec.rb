require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate presence of name" do
    cat = Cat.create age:5, enjoys:'Long walks on the beach', image:'https://thiscatdoesnotexist.com/'
    # if the field of name is empty send me an error
    expect(cat.errors[:name]).to_not be_empty
  end
  it "should validate presence of age" do
    cat = Cat.create
    expect(cat.errors[:age]).to_not be_empty
  end
  it "should validate presence of enjoys" do
    cat = Cat.create
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it "should validate presence of image" do
    cat = Cat.create
    expect(cat.errors[:image]).to_not be_empty
  end
  it 'should validates "enjoys" length to be 10' do
    cat = Cat.create name:'Mosey', age:5, enjoys:'Long walk', image:'https://thiscatdoesnotexist.com/'

    expect(cat.errors[:enjoys].first).to eq("is too short (minimum is 10 characters)")
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end
