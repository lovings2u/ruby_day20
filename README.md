# 20180706_day20

### ajax searching

- 일반 사이트에서 사용자가 해쉬태그나 제목으로 검색할 떄, 그에 해당하는 여러 추천 검색어, 혹은 관련 검색어가 뜨는 것을 확인할 수 있다. 우리도 이와 마찬가지로 사용자가 검색어를 우리가 만든 검색창에 입력할 때 서버에서 그에 해당하는 쿼리로 데이터를 검색해 해당 검색어를 포함/시작하는 제목을 구현할 수 있다.

*app/views/movies/index.html.erb*

```erb
<h1 id="title">Movies</h1>
<input type="text" class="form-control movie-title">
<div class="recomm-movie d-flex justify-content-start row">
<!-- 검색결과가 들어갈 위치 -->
</div>
...
<script>
  $(document).on('ready', function() {
      $('.movie-title').on('keyup', function() {
        var title = $(this).val();
        $.ajax({
          url: '/movies/search_movie',
          data: {
            q: title
          }
        })
      })
  });
</script>
```

- 사용자가 폼에서 키보드를 누를 때마다 서버로 쿼리에 포함될 검색어가 전달되고 서버에서 해당 정보를 받아서 사용자가 볼 수 있게 만드는 형식이다.

*config/routes.rb*

```ruby
...
  resources :movies do
	...
    collection do
      delete '/comments/:comment_id' => 'movies#destroy_comment'
      patch '/comments/:comment_id' => 'movies#update_comment'
      get '/search_movie' => 'movies#search_movie'
    end
  end
...
```

*app/controllers/movies_controller.rb*

```ruby
...
  def search_movie
    respond_to do |format|
      if params[:q].strip.empty?
        format.js {render 'no_content'}
      else
        @movies = Movie.where("title LIKE ?", "#{params[:q]}%")
        format.js {render 'search_movie'}
      end
    end
  end
...
```

- `respont_to` 는 사용자가 어떤 형식으로 요청을 보내왔는지에 따라서 respond를 결정한다. js로 요청(ajax)을 받았다면 js로, html로 요청을 받았다면 html형식으로 응답을 처리한다. `format.js` 나 `format.html` 의 모양으로 각 요청을 처리한다.

*app/views/movies/search_movie.html.erb*

```erb
console.log("찾음");
$('.recomm-movie').html(`
<% @movies.each do |movie| %>
<span class="badge badge-primary"><%= movie.title %></span>&nbsp;&nbsp;
<% end %>
`);
```

- 검색된 결과를 `badge`의 형태로 보여준다. 이 부분을 링크로 바꿔 검색결과를 나오게 한다면?



### Pagination

- Rails에서는 pagination이 굉장히 쉽게 구현된다. 잼을 이용한 방법인데, 사용하는 것은 쉽지만 왜 그렇게 동작하는 것을 이해하는 것도 중요하다.

*Gemfile*

```ruby
gem 'kaminari'
```

*app/controllers/movies_controller.rb*

```ruby
def index
    @movies = Movie.order(:title).page(params[:page])
  end
```

- 각 페이지 별로 Movie를 pagination 해서 보여준다.
- 각 페이지 별로 몇개의 데이터를 보여줄 지는 다음과 같이 설정할 수 있다.

*app/models/movie.rb*

```ruby
class Movie < ApplicationRecord
    ...
    paginates_per 8
end
```

- 더 자세한 내용은 [공식문서](https://github.com/kaminari/kaminari)를 참조한다.

