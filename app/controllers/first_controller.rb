class FirstController < ApplicationController
  def hello
    render plain: 'hello'
  end
  def word
    render plain: '我是这个世界的主宰'
  end

  def json
    render json: {name: 'yym', age: 12}
  end
end