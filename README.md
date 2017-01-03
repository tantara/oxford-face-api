# oxford-face-api
Ruby gem for Microsoft Oxford Face api

### Usage

```
require 'oxford/face/api'

KEY="YOUR_API_KEY" # from Microsoft Oxford
OxfordFaceApi.init(KEY)

f = OxfordFaceApi::Face.new

img_url = "https://raw.githubusercontent.com/tantara/oxford-face-api/master/test/example.jpg"
return_face_id = true
return_face_landmarks = false
return_face_attributes = "age,gender"

res = f.detect(img_url, return_face_id, return_face_landmarks, return_face_attributes)
puts res.body # => https://gist.github.com/tantara/5d72786bd3c6acc285a29ec44c4a8d1e
```
