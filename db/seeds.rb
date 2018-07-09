# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genres = ["Horror", "Thriller", "Action", "Drama", "Comedy", 
         "Romance", "SF", "Adventure"]
images = %w( http://www.visualdive.com/wp-content/uploads/2017/12/5-4.jpg
             http://www.visualdive.com/wp-content/uploads/2017/12/6-3.jpg
             http://file2.nocutnews.co.kr/newsroom/image/2017/12/04/20171204131928588431.jpg
             http://img.movist.com/?img=/x00/04/78/00_p1.jpg
             http://notefolio.net/data/img/69/1c/691c4e36eddf35b7a901a63db0b4d7664271f3efe75b55b28a48f1128d0f853b_v1.jpg
             http://mblogthumb2.phinf.naver.net/20160702_85/thisismyproof_1467450714283TbLyg_JPEG/6-maleficent_ver14_xxlg.jpg?type=w800
             http://img.hani.co.kr/imgdb/resize/2017/0306/00500005_20170306.JPG
             http://imgmovie.naver.com/mdi/mi/0398/39841_P03_231710.jpg
             http://cfile224.uf.daum.net/image/16473849512C108306E249
             http://img.danawa.com/images/descFiles/4/402/3401557_1497838111988.jpeg)
User.create(email: "aa@a.a", password: "123456", password_confirmation: "123456")             
30.times do
Movie.create(title: Faker::Movie.quote, genre: genres.sample, director: Faker::FunnyName.three_word_name,
             actor: Faker::FunnyName.two_word_name, remote_image_path_url: images.sample,
             description: Faker::Lorem.paragraph, user_id: 1)
end