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
    it 'can create a cat in the database and recieve the proper response' do
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
     it 'can cannot create a cat without a name' do
      cat_params = {
        cat: {
          age: 5, 
          enjoys: "showing up in places randomly", 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['name']).to include "can't be blank"
    end
     it 'can cannot create a cat without an age' do
      cat_params = {
        cat: {
          name: "Mosey", 
          enjoys: "showing up in places randomly", 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['age']).to include "can't be blank"
    end
    it 'can cannot create a cat without an enjoys' do
      cat_params = {
        cat: {
          name: "Mosey", 
          age: 5, 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['enjoys']).to include "can't be blank"
    end
    it 'can cannot create a cat without an image' do
      cat_params = {
        cat: {
          name: "Mosey", 
          age: 5, 
          enjoys: "Long walks on the beach"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['image']).to include "can't be blank"
    end
    it 'can cannot create a cat without an enjoys of mimimum length of 10' do
      cat_params = {
        cat: {
          name: "Mosey", 
          age: 5, 
          enjoys: "Long walk",
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      post '/cats', params: cat_params

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['enjoys']).to include "is too short (minimum is 10 characters)"
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
    it 'cannot update a cat at a particular ID without a name' do

      Cat.create name: "Mosey", age: 5, enjoys: "showing up in places randomly", image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"

      cat_params = {
        cat: {
          name: nil,
          age: 6, 
          enjoys: "showing up in places randomly", 
          image:"https://www.grxstatic.com/4f3rgqwzdznj/4IMpm0CX5kGpinJiG2ME8r/2dae4b7ac7c3008359bc7fe690bab18f/cat_on_fence_outside-1324776163.jpg?format=pjpg&auto=webp&width=704"
        }
      }

      cat = Cat.last
      
      patch "/cats/#{cat.id}", params: cat_params

      updated_cat = Cat.find(cat.id)

      expect(response).to have_http_status(422)

      json_response = JSON.parse(response.body)

      expect(json_response['name']).to include "can't be blank"
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
