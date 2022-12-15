require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'can get a list of all the cats' do
    
      Cat.create name: "Mosey", age: 5, enjoys: "showing up in places randomly", image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"

      # get request to the /cats url
      get '/cats'

    #  print response
    #  print response.body
    #  p 'JSON'
    #  print JSON.parse response.body

    cat = JSON.parse response.body

    expect(response).to have_http_status(200)
    expect(cat.length).to eq(1) 
    end
  end
  describe "POST /create" do
    it 'can get create a cat in the database and recieve the proper response' do
      cat_params = {
        cat: {
          name: "Mosey", 
          age: 5, 
          enjoys: "showing up in places randomly", 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(200)

      cat = Cat.last

      expect(cat.name).to eq('Mosey')
    end
  end
  describe 'PATCH /update' do
    it 'can update a cat at a particular ID' do

      Cat.create name: "Mosey", age: 5, enjoys: "showing up in places randomly", image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"

      cat_params = {
        cat: {
          name: "Mosey", 
          age: 6, 
          enjoys: "showing up in places randomly", 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      cat = Cat.last
      
      patch "/cats/#{cat.id}", params: cat_params

      updated_cat = Cat.find(cat.id)

      expect(response).to have_http_status(200)

      expect(updated_cat.age).to eq(6)
    end
  end
  describe 'DELETE /destroy' do
    it 'deletes a cat' do
      Cat.create name: "Mosey", age: 5, enjoys: "showing up in places randomly", image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"

      cat = Cat.last
      delete "/cats/#{cat.id}"

      expect(response).to have_http_status(200)

      expect(Cat.all).to be_empty
    end
  end
end
